<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>All Products</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #ffffff;
        }

        .container {
            padding-top: 3rem;
            padding-bottom: 3rem;
        }

        .card-sh {
            border: none;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        .card-header {
            background-color: #292F36;
            color: #fff;
            padding: 1.25rem;
            text-align: center;
            border-radius: 15px 15px 0 0;
        }

        .card-body {
            padding: 2rem;
            background-color: #f9f9f9;
        }

        .table {
            border-radius: 15px;
            overflow: hidden;
        }

        .btn-primary {
            background-color: #292F36;
            border-radius: 10px;
            transition: all 0.3s ease-in-out;
        }

        .btn-primary:hover {
            background-color: black;
            border-color: #e6453d;
        }

        .btn-danger:hover {
            background-color: #e6453d;
            border-color: black;
        }

        .text-success, .text-danger {
            font-size: 1rem;
            margin-top: 0.5rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-sh">
                        <div class="card-header position-relative text-center">
    <a href="${pageContext.request.contextPath}/admin/" class="text-decoration-none text-white position-absolute" style="left: 0;">
        <i class="fa-solid fa-arrow-left back-btn"></i> Back
    </a>
    <p class="mb-0">All Products</p>
</div>

                        <div class="card-body">

                            <!-- Success Message -->
                            <c:if test="${not empty sessionScope.succMsg}">
                                <p class="text-success">${sessionScope.succMsg}</p>
                                <%
                                    session.removeAttribute("succMsg");
                                %>
                            </c:if>

                            <!-- Error Message -->
                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p class="text-danger">${sessionScope.errorMsg}</p>
                                <%
                                    session.removeAttribute("errorMsg");
                                %>
                            </c:if>

                            <!-- Search Form -->
                            <form action="${pageContext.request.contextPath}/admin/products" method="get" class="mb-4">
                                <div class="row">
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="ch" placeholder="Search product">
                                    </div>
                                    <div class="col-md-4">
                                        <button class="btn btn-primary col">Search</button>
                                    </div>
                                </div>
                            </form>

                            <!-- Product Table -->
                            <table class="table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col">Sl No</th>
                                        <th scope="col">Image</th>
                                        <th scope="col">Title</th>
                                        <th scope="col">Category</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Discount</th>
                                        <th scope="col">Discount Price</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Stock</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${products}" varStatus="c">
                                        <tr>
                                            <th scope="row"><c:out value="${c.index + 1}"/></th>
                                            <td><img src="${pageContext.request.contextPath}/img/product_img/${p.image}" width="70px" height="70px"></td>
                                            <td><c:out value="${p.title}"/></td>
                                            <td><c:out value="${p.category}"/></td>
                                            <td><c:out value="${p.price}"/></td>
                                            <td><c:out value="${p.discount}"/></td>
                                            <td><c:out value="${p.discountPrice}"/></td>
                                            <td><c:out value="${p.isActive}"/></td>
                                            <td><c:out value="${p.stock}"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/editProduct/${p.id}" class="btn btn-sm btn-primary">
                                                    <i class="fa-solid fa-pen-to-square"></i> Edit
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/deleteProduct/${p.id}" class="btn btn-sm btn-danger">
                                                    <i class="fa-solid fa-trash"></i> Delete
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <!-- Pagination -->
                            <div class="row">
                                <div class="col-md-4">Total Products: <c:out value="${totalElements}"/></div>
                                <div class="col-md-8">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-end">
                                            <li class="page-item <c:if test='${isFirst}'>disabled</c:if>">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/products?pageNo=${pageNo - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>

                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item <c:if test='${pageNo + 1 == i}'>active</c:if>">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/products?pageNo=${i - 1}">
                                                        <c:out value="${i}"/>
                                                    </a>
                                                </li>
                                            </c:forEach>

                                            <li class="page-item <c:if test='${isLast}'>disabled</c:if>">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/products?pageNo=${pageNo + 1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>

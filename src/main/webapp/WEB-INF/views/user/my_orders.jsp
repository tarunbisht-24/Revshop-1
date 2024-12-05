<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>My Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <section>
        <div class="container mt-5 p-5">
            <div class="row">
                <p class="text-center fs-3">My Orders</p>

                <c:if test="${sessionScope.succMsg != null}">
                    <p class="text-success fw-bold text-center">${sessionScope.succMsg}</p>
                    <c:out value="${sessionScope.succMsg}"/>
                    <c:out value="${commnServiceImpl.removeSessionMessage()}"/>
                </c:if>

                <c:if test="${sessionScope.errorMsg != null}">
                    <p class="text-danger fw-bold text-center">${sessionScope.errorMsg}</p>
                    <c:out value="${sessionScope.errorMsg}"/>
                    <c:out value="${commnServiceImpl.removeSessionMessage()}"/>
                </c:if>

                <div class="col-md-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Order Id</th>
                                <th scope="col">Date</th>
                                <th scope="col">Product Details</th>
                                <th scope="col">Price</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <th scope="row">${o.orderId}</th>
                                    <td>${o.orderDate}</td>
                                    <td>${o.product.title}</td>
                                    <td>
                                        Quantity : ${o.quantity} <br>
                                        Price : ${o.price} <br>
                                        Total Price : ${o.quantity * o.price}
                                    </td>
                                    <td>${o.status}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.status != 'Cancelled'}">
                                                <a href="${pageContext.request.contextPath}/user/update-status?id=${o.id}&st=6" class="btn btn-sm btn-danger">Cancel</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" class="btn btn-sm btn-danger disabled">Cancel</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</body>
</html>

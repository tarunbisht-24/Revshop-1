<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Cart Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5">
            <div class="card card-sh">
                <div class="card-header text-center">
                    <p class="fs-4">Cart Page</p>

                    <!-- Display success message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                        <c:remove var="sessionScope.succMsg" />
                    </c:if>

                    <!-- Display error message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                        <c:remove var="sessionScope.errorMsg" />
                    </c:if>
                </div>

                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sl No</th>
                                <th scope="col">Image</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Price</th>
                                <th scope="col" class="text-center">Quantity</th>
                                <th scope="col">Total Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cart" items="${carts}" varStatus="status">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/img/product_img/${cart.product.image}" width="70px" height="70px">
                                    </td>
                                    <td>${cart.product.title}</td>
                                    <td>${cart.product.discountPrice}</td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/user/cartQuantityUpdate?sy=de&cid=${cart.id}">
                                            <i class="fa-solid fa-minus"></i>
                                        </a> [ ${cart.quantity} ] 
                                        <a href="${pageContext.request.contextPath}/user/cartQuantityUpdate?sy=in&cid=${cart.id}">
                                            <i class="fa-solid fa-plus"></i>
                                        </a>
                                    </td>
                                    <td>${cart.totalPrice}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="4"></td>
                                <td class="fw-bold">Total Price</td>
                                <td class="fw-bold">&#8377; ${totalOrderPrice}</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-warning">Proceed Payment</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body> 
</html>

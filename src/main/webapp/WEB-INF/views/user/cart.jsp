<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Cart Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Styling and Animation */

        /* Card Styling */
        .card-sh {
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s;
        }
        .card-sh:hover {
            transform: scale(1.02);
        }

        /* Cart Header */
        .card-header {
            background-color: #f8f9fa;
            font-size: 1.25rem;
            font-weight: bold;
        }

        /* Image Styling */
        .cart-item img {
            border-radius: 5px;
            transition: transform 0.3s;
        }
        .cart-item img:hover {
            transform: scale(1.1);
        }

        /* Button Effects */
        .btn {
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn:hover {
            background-color: #ffc107;
            transform: translateY(-2px);
        }
        .btn:disabled {
            background-color: #d3d3d3;
            cursor: not-allowed;
        }

        /* Fade-in Animation */
        .fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Quantity Controls */
        .quantity-control {
            display: inline-flex;
            align-items: center;
            font-size: 1.2rem;
        }
        .quantity-control .btn {
            margin: 0 5px;
            padding: 5px 10px;
            color: #343a40;
            background-color: #f1f1f1;
            border: none;
        }
        .quantity-control .btn:hover {
            background-color: #e0e0e0;
        }

        /* Total Price Styling */
        .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #ff5722;
        }
    </style>
</head>
<body>
    <section>
      <div class="container-fluid mt-5 p-5 fade-in">
    <div class="card card-sh">
        <div class="card-header text-center">
            Cart Page
            <c:if test="${not empty sessionScope.succMsg}">
                <p class="text-success fw-bold fade-in">${sessionScope.succMsg}</p>
                <c:remove var="sessionScope.succMsg" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <p class="text-danger fw-bold fade-in">${sessionScope.errorMsg}</p>
                <c:remove var="sessionScope.errorMsg" />
            </c:if>
        </div>

        <div class="card-body">
            <!-- Check if the cart is empty -->
            <c:if test="${empty carts}">
                <p class="text-center text-muted">Your cart is empty.</p>
            </c:if>

            <!-- If cart is not empty, display items -->
            <c:if test="${not empty carts}">
                <c:forEach var="cart" items="${carts}" varStatus="status">
                    <div class="row mb-4 border-bottom pb-3 fade-in cart-item">
                        <div class="col-md-4 text-center">
                            <img src="${pageContext.request.contextPath}/img/product_img/${cart.product.image}" 
                                 alt="${cart.product.title}" class="img-fluid" style="max-width: 150px;">
                        </div>

                        <div class="col-md-8">
                            <h5>${cart.product.title}</h5>
                            <p>Price: &#8377; ${cart.product.discountPrice}</p>
                            <p>Total Price: <span class="total-price">&#8377; ${cart.totalPrice}</span></p>

                            <div class="quantity-control">
                                <a href="${pageContext.request.contextPath}/user/cartQuantityUpdate?sy=de&cid=${cart.id}" 
                                   class="btn btn-light btn-sm">
                                    <i class="fa-solid fa-minus"></i>
                                </a> 
                                <span class="fw-bold">[ ${cart.quantity} ]</span>
                                <a href="${pageContext.request.contextPath}/user/cartQuantityUpdate?sy=in&cid=${cart.id}" 
                                   class="btn btn-light btn-sm">
                                    <i class="fa-solid fa-plus"></i>
                                </a>
                            </div>
                            <div class="mt-2">
                                        <a href="${pageContext.request.contextPath}/user/cartRemoveItem?cid=${cart.id}" 
                                           class="btn btn-danger btn-sm">Remove</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Total Price and Proceed Button -->
                <div class="text-end my-3 fade-in">
                    Total Price: <span class="total-price">&#8377; ${totalOrderPrice}</span>
                </div>
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/user/orders" 
                       class="btn btn-warning" 
                       <c:if test="${totalOrderPrice == 0}">disabled</c:if>>Proceed Payment</a>
                </div>
            </c:if>
        </div>
    </div>
</div>
    </section>
</body>
</html>
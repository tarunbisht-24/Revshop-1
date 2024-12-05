<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Product Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
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

        .product-card {
            position: relative;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
        }

        .wishlist-heart {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 24px;
            color: white;
            border: 2px solid white;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.3);
            padding: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .wishlist-heart:hover {
            background-color: #ff4b4b;
            color: white;
            border-color: #ff4b4b;
        }

        .text-success, .text-danger {
            font-size: 1rem;
            margin-top: 0.5rem;
            font-weight: 600;
        }

        /* New styles for clickable elements */
        a {
            color: #292F36; /* Change link color */
            text-decoration: none; /* Remove underline */
        }
        .page-link-span {
    		    position: relative;
    display: block;
    padding: .5rem .75rem;
/*     margin-left: -1px; */
    line-height: 1.25;
    color: white;
    background-color: #292F36;
    border: 1px solid #dee2e6;/* Change text color if needed */
        }

        a:hover {
            color: #ff4b4b; /* Change hover color */
            text-decoration: underline; /* Add underline on hover */
        }

        .btn-primary {
            background-color: #292F36; /* Change button background color */
            border: none; /* Remove border */
        }

        .btn-primary:hover {
            background-color: #ff4b4b; /* Change button hover color */
            color: white; /* Ensure text color remains visible */
        }
        .list-group-item.active {
    background-color: #292F36 !important; /* Override Bootstrap's default */
    color: white; /* Change text color if needed */
}

        @media (max-width: 768px) {
            .product-card {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container">
            <div class="card card-sh">
                <div class="card-header">
                    <p class="mb-0">Products</p>
                </div>
                <div class="card-body">
                    <!-- Search Form -->
                    <form action="/products" method="get" class="mb-4">
                        <div class="input-group">
                            <input type="text" class="form-control" name="ch" placeholder="Search product">
                            <button class="btn btn-primary">
                                <i class="fa-solid fa-magnifying-glass"></i> Search
                            </button>
                        </div>
                    </form>

                    <!-- Category Filter -->
                    <div class="row">
                        <div class="col-md-2">
                            <div class="list-group">
                                <p class="fs-5">Category</p>
                                <a href="/products" class="list-group-item list-group-item-action ${paramValue == '' ? 'active' : ''}" aria-current="true">All</a>
                                <c:forEach var="c" items="${categories}">
                                    <a href="/products?category=${c.name}" class="list-group-item list-group-item-action ${paramValue == c.name ? 'active' : ''}">
                                        ${c.name}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Product Cards -->
                        <!-- Product Cards -->
<div class="col-md-10">
    <div class="row">
        <c:if test="${productsSize > 0}">
            <c:forEach var="p" items="${products}">
                <div class="col-md-12 mt-2"> <!-- One product per row -->
                    <div class="card product-card">
                        <a href="/user/addWishlist?productId=${p.id}" class="wishlist-heart">
                            <i class="fas fa-heart"></i>
                        </a>
                        <div class="card-body d-flex align-items-center"> <!-- Flexbox for alignment -->
                            <img src="/img/product_img/${p.image}" alt="${p.title}" width="150" height="150" class="me-3"> <!-- Margin right -->
                            <div class="product-details flex-grow-1"> <!-- Allow text to take remaining space -->
                                <p class="fs-5">${p.title}</p>
                                <p class="fs-6 fw-bold">
                                    &#8377; ${p.discountPrice} <br>
                                    <span class="text-decoration-line-through text-secondary">&#8377; ${p.price}</span>
                                    <span class="fs-6 text-success">${p.discount}% off</span>
                                </p>
                                <a href="/product/${p.id}" class="btn btn-primary btn-view-details">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${productsSize <= 0}">
            <p class="fs-4 text-center mt-4 text-danger">Product not available</p>
        </c:if>
    </div>
</div>


                    <!-- Pagination -->
                    <div class="row">
<%--                         <div class="col-md-4">Total Products: ${totalElements}</div>
 --%>                        <div class="col-md-8">
                            <c:if test="${productsSize > 0}">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-end">
                                        <li class="page-item ${isFirst ? 'disabled' : ''}">
                                            <a class="page-link" href="/products?pageNo=${pageNo - 1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                           
                                        
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${pageNo + 1 == i ? 'active' : ''}">
                                        		
                                                	<a class="page-link-span" href="/products?pageNo=${i - 1}">${i}</a>
                                            	
                                            </li>
                                        </c:forEach>
                                        
                                        <li class="page-item ${isLast ? 'disabled' : ''}">
                                            <a class="page-link" href="/products?pageNo=${pageNo + 1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>

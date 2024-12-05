<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Carousel image settings */
        .carousel-inner img {
            width: 100%;
            height: 350px; /* Adjust as needed */
            object-fit: cover;
        }

        /* Card styles */
        .card, .cus-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover, .cus-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card img, .cus-card img {
            width: 100%;
            height: 200px; /* Adjust as needed */
            object-fit: cover;
        }

        .card-body, .cus-card .card-body {
            padding: 15px;
        }

        .card-body a, .cus-card .card-body a {
            color: #333;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
        }

        .card-body a:hover, .cus-card .card-body a:hover {
            text-decoration: underline;
        }

        /* Category container styles */
        .category-container .card {
            border-radius: 50%;
            overflow: hidden;
        }

        .category-container img {
            width: 100%;
            height: 150px; /* Adjust as needed */
            object-fit: cover;
            border-radius: 50%;
        }

        /* Product badge discount */
        .badge-discount {
            background-color: #ff5722;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            position: absolute;
            top: 10px;
            left: 10px;
        }

        /* Price styles */
        .real-price {
            font-size: 20px;
            font-weight: 600;
            color: #027a3e;
        }

        .product-price {
            font-size: 17px;
            text-decoration: line-through;
            color: #999;
        }

        .product-discount {
            font-size: 15px;
            color: #ff5722;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .card-item {
                flex: 1 1 calc(50% - 1rem);
            }

            .card img, .cus-card img {
                height: 150px; /* Adjust as needed */
            }
        }

        @media (max-width: 576px) {
            .card-item {
                flex: 1 1 100%;
            }

            .card img, .cus-card img {
                height: 120px; /* Adjust as needed */
            }
        }
    </style>
</head>
<body>
    <section>
        <!-- Start Slider -->
        <div id="carouselAutoplaying" class="carousel slide carousel-dark mt-3 mb-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/img/Images/image1.jpg" class="d-block w-100" alt="Image 1">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/Images/image2.jpg" class="d-block w-100" alt="Image 2">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/Images/image3.jpg" class="d-block w-100" alt="Image 3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <!-- end of carousel -->

        <!-- Start Category Module -->
        <div class="container my-5">
            <div class="row text-center">
                <p class="fs-4 mb-4">Category</p>
                <div class="category-container d-flex justify-content-center">
                    <c:forEach var="category" items="${categories}">
                        <div class="col-md-2 col-sm-4 mb-4">
                            <div class="card rounded-circle shadow-sm">
                                <div class="product-image-container">
                                    <img src="${pageContext.request.contextPath}/img/category_img/${category.imageName}" class="img-fluid" alt="${category.name}">
                                </div>
                                <div class="card-body text-center">
                                    <a href="${pageContext.request.contextPath}/products?category=${category.name}" class="d-block mt-2">${category.name}</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- End Category Module -->

        <!-- Start Latest Product Module -->
        <div class="container-fluid bg-light py-5">
            <div class="row text-center mb-4">
                <p class="fs-4 mb-0">Latest Products</p>
            </div>

            <div class="row row-cols-1 row-cols-md-4 g-4">
                <c:forEach var="product" items="${products}">
                    <div class="col">
                        <div class="card cus-card position-relative">
                            <a href="${pageContext.request.contextPath}/product/${product.id}" style="text-decoration: none;">
                                <div class="position-relative">
                                    <img src="${pageContext.request.contextPath}/img/product_img/${product.image}" class="card-img-top img-fluid" alt="${product.title}">
                                    <c:if test="${product.discount > 0}">
                                        <span class="badge-discount">${product.discount}% off</span>
                                    </c:if>
                                </div>
                                <div class="card-body text-center">
                                    <h5 class="card-title mt-2">${product.title}</h5>
                                    <p class="mb-1">
                                        <span class="real-price">&#8377;${product.discountPrice}</span>
                                        <c:if test="${product.discount > 0}">
                                            <span class="product-price">&#8377;${product.price}</span>
                                        </c:if>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/product/${product.id}" class="btn btn-primary mt-2">View Product</a>
                                </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- End Latest Product Module -->

    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>

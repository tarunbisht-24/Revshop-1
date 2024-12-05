<%@include file="../base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Seller Dashboard</title>
    <style>
        body {
            background-color: #f4f7f8;
        }
        .container {
            background-color: #292F36;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 3rem 2rem;
        }
        .row {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .card {
            display: flex;
            align-items: center;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin: 1.5rem 0;
            background-color: #f8f9fa;
            width: 100%;
            padding: 1rem;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .card-body {
            display: flex;
            align-items: center;
            width: 100%;
        }
        .card img {
            width: 60px;
            height: 60px;
            object-fit: contain;
            margin-right: 1rem;
        }
        .card-title {
            font-size: 1.25rem;
            margin-top: 0.5rem;
            color: #333;
        }
        .card a {
            text-decoration: none;
            color: #007bff;
            transition: color 0.2s ease;
        }
        .card a:hover {
            color: #0056b3;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .card {
                width: 90%;
                flex-direction: column;
                text-align: center;
            }
            .card img {
                margin-bottom: 1rem;
                margin-right: 0;
            }
        }

        @media (max-width: 576px) {
            .card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container">
            <h2 class="text-center mb-5" style="color: white">Seller Dashboard</h2>
            <div class="row">
                <!-- Add Product Card -->
                <div class="col-md-12">
                    <div class="card">
                        <a href="/admin/AddProduct">
                            <div class="card-body">
                                <img src="/img/Images/Productsi.png" alt="Add Product">
                                <h4 class="card-title">Add Product</h4>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Add Category Card -->
                <div class="col-md-12">
                    <div class="card">
                        <a href="/admin/category">
                            <div class="card-body">
                                <img src="/img/Images/cat.png" alt="Add Category">
                                <h4 class="card-title">Add Category</h4>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- View Products Card -->
                <div class="col-md-12">
                    <div class="card">
                        <a href="/admin/products">
                            <div class="card-body">
                                <img src="/img/Images/prod.png" alt="View Product">
                                <h4 class="card-title">View Product</h4>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Orders Card -->
                <div class="col-md-12">
                    <div class="card">
                        <a href="/admin/orders">
                            <div class="card-body">
                                <img src="/img/Images/orderi.png" alt="Orders">
                                <h4 class="card-title">Orders</h4>
                            </div>
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </section>
</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create an Account on RevShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #FDFFFC;
            color: #292F36;
            transition: background-color 0.3s ease;
        }

        .form-container {
            margin-top: 50px;
            animation: fadeIn 0.8s ease;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: translateY(10px);
            opacity: 0;
            animation: slideIn 0.6s forwards;
            animation-delay: 0.2s;
        }

        @keyframes slideIn {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .card-header {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .card-header:hover {
            transform: scale(1.05);
        }

        .card-body {
            padding: 30px;
        }

        .form-group label {
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .input-form {
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: white;
            transition: box-shadow 0.3s ease;
        }

        .input-form input, .input-form select {
            border: none;
            width: 100%;
            height: 40px;
            border-radius: 10px;
            padding-left: 10px;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }

        .input-form input:focus, .input-form select:focus {
            outline: none;
            border: 2px solid #292F36;
            box-shadow: 0 0 5px rgba(41, 47, 54, 0.5);
        }

        .button {
            background-color: #292F36;
            border: none;
            border-radius: 50px;
            padding: 10px 20px;
            color: #FDFFFC;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
            display: block;
            width: 100%;
            animation: bounce 0.6s ease infinite alternate;
        }

        @keyframes bounce {
            from {
                transform: translateY(0);
            }
            to {
                transform: translateY(-5px);
            }
        }

        .button:hover {
            background-color: #1b1e24;
            transform: scale(1.05);
        }

        .card-footer {
            background-color: #f8f9fa;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .card-footer a {
            color: #292F36;
            font-weight: bold;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .card-footer a:hover {
            text-decoration: underline;
            color: #1b1e24;
        }

        .form-row {
            margin-bottom: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="container form-container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card-header text-center">
                    <!-- Display Success Message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <div class="alert alert-success" role="alert">
                            ${sessionScope.succMsg}
                            <c:remove var="sessionScope.succMsg" />
                        </div>
                    </c:if>
                    <!-- Display Error Message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-danger" role="alert">
                            ${sessionScope.errorMsg}
                            <c:remove var="sessionScope.errorMsg" />
                        </div>
                    </c:if>
                </div>
                <div class="card shadow p-3 mb-5 rounded">
                    <div class="card-header">
                        Create an Account on RevShop
                    </div>
                    <div class="card-body">
                        <form class="form" action="/saveUser" enctype="multipart/form-data" method="post">
                            <!-- Row 1: Full Name and Mobile Number -->
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="name">Full Name</label>
                                        <div class="input-form">
                                            <input id="name" placeholder="Enter your Full Name" type="text" name="name" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="mobileNumber">Mobile Number</label>
                                        <div class="input-form">
                                            <input id="mobileNumber" placeholder="Enter your Mobile Number" type="number" name="mobileNumber" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Row 2: Email and Address -->
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <div class="input-form">
                                            <input id="email" placeholder="Enter your Email" type="email" name="email" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <div class="input-form">
                                            <input id="address" placeholder="Enter your Address" type="text" name="address" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Row 3: City, State, and Pincode -->
                            <div class="form-row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="city">City</label>
                                        <div class="input-form">
                                            <input id="city" placeholder="Enter your City" type="text" name="city" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="state">State</label>
                                        <div class="input-form">
                                            <input id="state" placeholder="Enter your State" type="text" name="state" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="pincode">Pincode</label>
                                        <div class="input-form">
                                            <input id="pincode" placeholder="Enter your Pincode" type="number" name="pincode" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Row 4: Password and Confirm Password -->
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <div class="input-form">
                                            <input id="password" placeholder="Enter your Password" type="password" name="password" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="confirmpassword">Confirm Password</label>
                                        <div class="input-form">
                                            <input id="confirmpassword" placeholder="Confirm your Password" type="password" name="confirmpassword" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Row 5: Profile Image and User Role -->
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="img">Profile Image</label>
                                        <div class="input-form">
                                            <input id="img" type="file" name="img">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="userRole">User Role</label>
                                        <div class="input-form">
                                            <select id="userRole" name="role" required>
                                                <option value="buyer" selected>Buyer</option>
                                                <option value="seller">Seller</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="button mt-4">Register</button>
                            <div class="card-footer">
                                Have an account? <a href="/signin">Login</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
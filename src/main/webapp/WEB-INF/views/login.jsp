<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <title>Login Page</title>
    <style>
        /* Reset CSS */
        
        /* Flex container to hold form and image side by side */
.flex-container {
    display: flex;
    justify-content: space-between; /* Align items */
    align-items: center; /* Center items vertically */
}

/* Form content styling */
.form-content {
    flex: 1; /* Allow form to take available space */
    margin-right: 20px; /* Space between form and image */
}

/* Image styling */
.form-image {
    flex: 0 300px; /* Fixed width for the image container */
}

.image {
    max-width: 100%; /* Responsive image */
    height: auto; /* Maintain aspect ratio */
    border-radius: 8px; /* Optional: rounded corners */
}
        
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body */
        body {
            background-color: #FDFFFC; /* Off-white */
            color: #292F36; /* Dark blue-gray for text */
            line-height: 1.6;
        }

        /* Centering Container */
        .register-section {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 4rem 1rem;
            background-color: #FDFFFC; /* Off-white background */
        }

        .form-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Card Wrapper */
        .form-wrapper {
            width: 600px;
/*             margin: 0 auto; */
            margin-right: 10px;
            background-color: #FFF;
            padding: 2rem;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center; /* Center content */
        }

        /* Logo Styling */
        .logo {
            max-width: 150px;
            margin: 0 auto 20px; /* Margin below logo */
            display: block;
            height: 250px;
            width: 400px;
        }

        /* Header */
        h1 {
            margin-bottom: 1.5rem;
            color: #292F36; /* Dark blue-gray */
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem; /* Increased spacing */
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 1.1rem; /* Increased font size */
            color: #292F36; /* Dark blue-gray */
        }

        input {
            width: 100%;
            padding: 1rem; /* Increased padding */
            border: 1px solid #827F9F; /* Muted lavender-gray */
            border-radius: 4px;
            font-size: 1rem;
        }

        input:focus {
            outline: none;
            border-color: #292F36; /* Dark blue-gray focus */
        }

        .btn {
            display: block;
            width: 100%;
            padding: 1.2rem; /* Increased button padding */
            background-color: #292F36; /* Dark blue-gray */
            color: #FDFFFC; /* Off-white */
            border: none;
            border-radius: 50px;
            font-size: 1.2rem; /* Increased font size */
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
        }

        .btn:hover {
            background-color: #827F9F; /* Muted lavender */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-wrapper {
                padding: 1.5rem;
            }
        }

        .flex-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem; /* Added spacing */
        }

        .span {
            font-size: 14px;
            color: #292F36;
            cursor: pointer;
        }

        .alert {
            background-color: #f8d7da; /* Light red background */
            color: #721c24; /* Dark red text */
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>
   <div class="form-container">
    <div class="form-wrapper">
        <h1>Login</h1>

        <c:if test="${param.error != null}">
            <div class="alert">
                <h1 style="color:red;"><c:out value="${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}" /></h1>
            </div>
        </c:if>

        <c:if test="${param.logout != null}">
            <div class="alert">You have been logged out successfully.</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input id="email" placeholder="Enter your Email" type="email" name="username" required />
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input id="password" placeholder="Enter your Password" type="password" name="password" required />
            </div>
            <div class="flex-row">
                <div>
                    <input type="checkbox" id="remember" name="remember" />
                    <label for="remember">Remember me</label>
                </div>
                <span class="span"><a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a></span>
            </div>
            <button type="submit" class="btn">Sign In</button>
            <div class="card-footer text-center">
                Don't have an account? <span class="span"><a href="${pageContext.request.contextPath}/register">Sign Up</a></span>
            </div>
        </form>
    </div>

    <!-- Image Outside of the Box -->
    <div class="form-image">
        <img src="${pageContext.request.contextPath}/images/login.png" alt="Your Image" class="image" />
    </div>
</div>


</body>
</html>

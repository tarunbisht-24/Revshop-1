<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Revshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <!-- Internal CSS -->
    <style>
    /* Import Google Font */
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

    body {
        font-family: 'Poppins', sans-serif;
        padding-top: 56px; /* Adjust based on navbar height */
        background: #292F36
    }

    /* Navbar styles */
    .navbar {
        background: #292F36;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        padding: 0.8rem 1rem;
        transition: background 0.3s ease;
    }

/*     .navbar:hover { */
/*         background: linear-gradient(45deg, #2F2936, #40394D); */
/*     } */

    .navbar-brand {
        color: #fff !important;
        font-size: 1.3rem;
        margin-right: 2rem; /* Add space between brand and toggler */
    }

    /* Navbar links */
    .navbar-nav .nav-link {
        color: #FFF !important;
        font-size: 1.1rem;
        padding: 0.6rem 1rem; /* Uniform padding for links */
        transition: color 0.2s ease, transform 0.3s ease;
    }

    .navbar-nav .nav-link.active,
    .navbar-nav .nav-link:hover {
        color: #ffdf00 !important;
        transform: scale(1.1);
    }

    /* Navbar spacing adjustments */
    .navbar-nav .nav-item {
        margin: 0 10px; /* Add horizontal space between menu items */
    }

    /* Navbar Toggler */
    .navbar-toggler {
        border: none;
    }

    .navbar-toggler-icon {
        background-image: url('data:image/svg+xml;charset=utf8,<svg viewBox="0 0 30 30" xmlns="http://www.w3.org/2000/svg"><path stroke="rgba(255,255,255, 0.6)" stroke-width="2" stroke-linecap="round" stroke-miterlimit="10" d="M4 7h22M4 15h22M4 23h22"/></svg>');
    }

    /* Search input style */
    .input-group {
        margin-left: 1rem; /* Adjust the left margin for search bar */
    }

    .input-group .form-control {
        border: 2px solid #FFF;
        border-radius: 30px 0 0 30px;
        padding-left: 1rem; /* Reduce padding to balance spacing */
        color: #333;
        background-color: #F9F9F9;
    }

    .input-group .form-control:focus {
        box-shadow: none;
        border-color: #2F2936;
    }

    .input-group .btn-primary {
        border-radius: 0 30px 30px 0;
        background-color: #2F2936;
        border-color: #2F2936;
    }

    .input-group .btn-primary:hover {
        background-color: #40394D;
    }

    /* Dropdown menu */
    .dropdown-menu {
        background-color: #2F2936;
        padding: 0.5rem; /* More compact dropdown padding */
        animation: fadeIn 0.3s ease-in-out;
    }

    .dropdown-item {
        color: #FFF;
        transition: background-color 0.3s ease;
    }

    .dropdown-item:hover {
        background-color: #555063;
    }

    /* Add fade-in effect for dropdown */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Animations */
    .navbar, .dropdown-menu {
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }
</style>

</head>
<body>
    <!-- Start Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
<a class="navbar-brand" href="#">RevShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            

            <!-- Search Form -->
            <form action="/products" method="get" class="d-flex ms-auto">
                <div class="input-group">
                    <input type="text" class="form-control" name="ch" placeholder="Search product">
                    <button class="btn btn-primary">
                        <i class="fa-solid fa-magnifying-glass"></i> Search
                    </button>
                </div>
            </form>
<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
    <li class="nav-item">
        <c:choose>
            <c:when test="${user.role == 'ROLE_ADMIN'}">
                <a class="nav-link active me-5" aria-current="page" href="/admin/">Home</a>
            </c:when>
            <c:when test="${user.role == 'ROLE_USER'}">
                <a class="nav-link active me-5" aria-current="page" href="/">Home</a>
            </c:when>
            <c:otherwise>
                <a class="nav-link active me-5" aria-current="page" href="/">Home</a> <!-- Default link -->
            </c:otherwise>
        </c:choose>
    </li>
    <li class="nav-item">
        <a class="nav-link active me-5" aria-current="page" href="/products">Product</a>
    </li>
    <li class="nav-item">
    	<c:if test="${user.role == 'ROLE_USER'}">
        	<a class="nav-link active" aria-current="page" href="/user/cart"><i class="fa-solid fa-cart-shopping"></i> Cart [ ${countCart} ]</a>
                         </c:if>
	</li>
	<li class="nav-item">
		<c:if test = "${user.role == 'ROLE_USER'}">
			<a class="nav-link active" aria-current="page" href="/user/wishlist"><i class="fa-solid fa-heart"></i> Wishlist</a>
		</c:if>
	</li>
	<li class="nav-item">
		<c:if test = "${user.role == 'ROLE_USER'}">
			<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/user/user-orders"><i class="fas fa-tag"></i> Orders</a>
		</c:if>
	</li>
</ul>
            
            
            <ul class="navbar-nav ms-3 mb-2 mb-lg-0">
                <c:choose>
                    <c:when test="${empty user}">
                        <li class="nav-item"><a class="nav-link" href="/signin">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="/register">Register</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        <img alt="" src="${pageContext.request.contextPath}/images/profile.png" style="height: 40px; width: 40px; border-radius: 50%; margin-right: 8px;">
        <span>${user.name}</span>
    </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/user/profile">Profile</a></li>
                                <li><a class="dropdown-item" href="/logout">Logout</a></li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

    <!-- End Navbar -->

    <!-- Start Footer -->
  
    <!-- End Footer -->

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../base.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Add Product</title>
<!-- Add Bootstrap CSS or any other required CSS/JS files -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    /* General Styling */
    body {
        background-color: #ffffff; /* Light grey background */
    }

    .container {
        padding-top: 3rem;
        padding-bottom: 3rem;
    }

    /* Card Styling */
    .card-sh {
        border: none;
        border-radius: 15px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        background-color: #292F36; /* White background for card */
    }

    .card-header {
        background-color: #292F36; /* Light coral color */
        color: #fff;
        padding: 1.25rem;
        text-align: center;
        border-radius: 15px 15px 0 0;
    }

    .card-header p {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 0;
    }

    .card-body {
        padding: 2rem;
        background-color: #f9f9f9; /* Off-white for the card body */
    }

    .form-control {
        border: 2px solid grey;
        border-radius: 10px;
    }

    /* Button Styling */
    .btn-primary {
        background-color: #292F36;
        border-color: white;
        border-radius: 10px;
        transition: all 0.3s ease-in-out;
        width: 100%;
    }

    .btn-primary:hover {
        background-color: black;
        border-color: #e6453d;
    }

    /* Text Success and Error Styling */
    .text-success, .text-danger {
        font-size: 1rem;
        margin-top: 0.5rem;
        font-weight: 600;
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .container {
            padding: 1rem;
        }

        .form-control, .btn {
            font-size: 0.875rem;
        }

        .btn {
            font-size: 0.875rem;
        }
    }

    @media (max-width: 576px) {
        .container {
            padding: 0.75rem;
        }

        .form-control, .btn {
            font-size: 0.75rem;
        }
    }
</style>
</head>
<body>
    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card card-sh">
                        <div class="card-header">
                            <p>Add Product</p>

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
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/saveProduct"
                                  method="post" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label>Enter Title</label> 
                                    <input type="text" name="title" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label>Enter Description</label>
                                    <textarea rows="3" class="form-control" name="description" required></textarea>
                                </div>

                                <div class="mb-3">
                                    <label>Category</label>
                                    <select class="form-control" name="category" required>
                                        <option value="">-- Select --</option>
                                        <!-- Iterating through categories using JSTL -->
                                        <c:forEach var="c" items="${categories}">
                                            <option value="${c.name}">${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label>Enter Price</label> 
                                    <input type="number" name="price" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label>Status</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="true" name="isActive" id="active" checked>
                                        <label class="form-check-label" for="active">Active</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="isActive" value="false" id="inactive">
                                        <label class="form-check-label" for="inactive">Inactive</label>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="mb-3 col-md-6">
                                        <label>Enter Stock</label> 
                                        <input type="text" name="stock" class="form-control" required>
                                    </div>
                                    <div class="mb-3 col-md-6">
                                        <label>Upload Image</label> 
                                        <input type="file" name="file" class="form-control" required>
                                    </div>
                                </div>

                                <button class="btn btn-primary mt-3" type="submit">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>

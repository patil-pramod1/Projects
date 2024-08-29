<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product - RevShop</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="includes/navbarseller.jsp" %>

<div class="container mt-4">
    <% if (session.getAttribute("auth") != null) { %>
        <h2>Add a New Product</h2>

        <!-- Modal for success message -->
        <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="successModalLabel">Success</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%= request.getAttribute("success") %>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for error message -->
        <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorModalLabel">Error</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%= request.getAttribute("error") %>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
    <!-- Your form fields -->

    <div class="form-group">
        <label for="vendorId">Vendor ID:</label>
        <input type="text" class="form-control" id="vendorId" name="vendorId" required>
    </div>
    <div class="form-group">
        <label for="productName">Product Name:</label>
        <input type="text" class="form-control" id="productName" name="productName" required>
    </div>
    <div class="form-group">
        <label for="description">Description:</label>
        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
    </div>
    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" class="form-control" id="price" name="price" step="0.01" required>
    </div>
    <div class="form-group">
        <label for="imageFile">Upload Image:</label>
        <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" required>
    </div>
    <div class="form-group">
        <label for="category">Category:</label>
        <input type="text" class="form-control" id="category" name="category" required>
    </div>
    <div class="form-group">
        <label for="stockQuantity">Stock Quantity:</label>
        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" required>
    </div>
    <button type="submit" class="btn btn-primary">Add Product</button>
</form>

    <% } else { %>
        <div class="alert alert-warning" role="alert">
            Please <a href="login_seller.jsp">login</a> to add products.
        </div>
    <% } %>
</div>

<script>
// Show the appropriate modal if the 'success' or 'error' attribute is present
$(document).ready(function() {
    <% if (request.getAttribute("success") != null) { %>
        $('#successModal').modal('show');
    <% } else if (request.getAttribute("error") != null) { %>
        $('#errorModal').modal('show');
    <% } %>
});
</script>
</body>
</html>

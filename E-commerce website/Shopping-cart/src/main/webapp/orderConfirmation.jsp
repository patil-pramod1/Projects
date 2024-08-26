<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .confirmation-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .confirmation-header {
            font-size: 1.5em;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-control {
            border-radius: 5px;
            padding: 10px;
        }

        .payment-options {
            margin-top: 20px;
        }

        .btn-submit {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <div class="container confirmation-container">
        <h2 class="confirmation-header">Order Confirmation</h2>

        <form action="ProcessOrderServlet" method="post">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter your full name" required>
            </div>

            <div class="form-group">
                <label for="address">Delivery Address:</label>
                <textarea class="form-control" id="address" name="address" rows="3" placeholder="Enter your delivery address" required></textarea>
            </div>

            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" class="form-control" id="city" name="city" placeholder="Enter your city" required>
            </div>

            <div class="form-group">
                <label for="state">State:</label>
                <input type="text" class="form-control" id="state" name="state" placeholder="Enter your state" required>
            </div>

            <div class="form-group">
                <label for="zipCode">Zip Code:</label>
                <input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="Enter your zip code" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter your phone number" required>
            </div>

            <div class="payment-options">
                <h4>Select Payment Method</h4>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="Credit Card" required>
                    <label class="form-check-label" for="creditCard">
                        Credit Card
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="debitCard" value="Debit Card" required>
                    <label class="form-check-label" for="debitCard">
                        Debit Card
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="PayPal" required>
                    <label class="form-check-label" for="paypal">
                        PayPal
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="Cash on Delivery" required>
                    <label class="form-check-label" for="cod">
                        Cash on Delivery
                    </label>
                </div>
            </div>

            <input type="hidden" name="cartId" value="<%= request.getParameter("cartId") %>" />

            <button type="submit" class="btn btn-primary btn-submit">Confirm Order</button>
        </form>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

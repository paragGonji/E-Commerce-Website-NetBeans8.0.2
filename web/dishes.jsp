<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dinner Dishes Order</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1597733333523-9b0a9b1d1c4c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }
        .card {
            margin-top: 50px;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
        }
        .card-header {
            background-color: #0d6efd;
            color: #fff;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .form-check-label {
            font-size: 1rem;
            font-weight: 500;
            display: flex;
            align-items: center;
        }
        .form-check-label i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 12px 25px;
            font-size: 1rem;
            transition: transform 0.3s ease-in-out;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
            transform: scale(1.05);
        }
        .tooltip-inner {
            background-color: #0d6efd;
            color: #fff;
        }
        .tooltip-arrow::before {
            border-top-color: #0d6efd !important;
        }
    </style>
</head>
<body>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>Select Your Dinner Dishes</h3>
                    </div>
                    <div class="card-body">
                        <form action="billDishes.jsp" method="POST">
                            <!-- Butter Chicken -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="dishes" value="Butter Chicken - $15" id="butterChicken">
                                <label class="form-check-label" for="butterChicken">
                                    <i class="fas fa-drumstick-bite"></i> Butter Chicken - $15
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Delicious butter chicken with creamy sauce.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Chicken Biryani -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="dishes" value="Chicken Biryani - $12" id="chickenBiryani">
                                <label class="form-check-label" for="chickenBiryani">
                                    <i class="fas fa-bowl-rice"></i> Chicken Biryani - $12
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Flavorful rice with tender chicken.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Tandoori Chicken -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="dishes" value="Tandoori Chicken - $18" id="tandooriChicken">
                                <label class="form-check-label" for="tandooriChicken">
                                    <i class="fas fa-fire"></i> Tandoori Chicken - $18
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Grilled chicken with rich spices.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Naan -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="dishes" value="Naan - $4" id="naan">
                                <label class="form-check-label" for="naan">
                                    <i class="fas fa-bread-slice"></i> Naan - $4
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Soft, oven-baked flatbread.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-primary">Generate Bill</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Initialize Tooltips -->
    <script>
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    </script>
</body>
</html>
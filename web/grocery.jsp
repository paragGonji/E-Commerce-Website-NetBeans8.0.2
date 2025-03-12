<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grocery Order</title>
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
                        <h3>Select Your Grocery Items</h3>
                    </div>
                    <div class="card-body">
                        <form action="bill.jsp" method="POST">
                            <!-- Rice -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Rice - $10" id="rice">
                                <label class="form-check-label" for="rice">
                                    <i class="fas fa-bowl-rice"></i> Rice - $50
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="High-quality basmati rice.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Wheat -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Wheat - $5" id="wheat">
                                <label class="form-check-label" for="wheat">
                                    <i class="fas fa-seedling"></i> Wheat - $100
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Organic wheat grains.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Sugar -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Sugar - $8" id="sugar">
                                <label class="form-check-label" for="sugar">
                                    <i class="fas fa-cube"></i> Sugar - $75
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Refined white sugar.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Oil -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Oil - $12" id="oil">
                                <label class="form-check-label" for="oil">
                                    <i class="fas fa-oil-can"></i> Oil - $110
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Pure vegetable oil.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Pulses -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Pulses - $7" id="pulses">
                                <label class="form-check-label" for="pulses">
                                    <i class="fas fa-pepper-hot"></i> Pulses - $50
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Assorted lentils and beans.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Salt -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Salt - $2" id="salt">
                                <label class="form-check-label" for="salt">
                                    <i class="fas fa-salt"></i> Salt - $40
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Iodized table salt.">
                                    <i class="fas fa-info-circle"></i>
                                </span>
                            </div>
                            <!-- Tea -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="items" value="Tea - $5" id="tea">
                                <label class="form-check-label" for="tea">
                                    <i class="fas fa-mug-hot"></i> Tea - $80
                                </label>
                                <span class="ms-2" data-bs-toggle="tooltip" data-bs-placement="right" title="Premium black tea leaves.">
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
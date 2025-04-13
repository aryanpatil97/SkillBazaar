<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SkillBazaar - ${param.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .menuBar {
            color: black;
            text-decoration: none;
            padding: 10px;
        }
        .menuBar:hover {
            color: green;
            text-decoration: none;
        }
        /* Custom styling */
        .btn-custom-green {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
        }
        .btn-custom-green:hover {
            background-color: #218838;
        }
        .navbar-nav {
            margin-left: auto; /* Pushes items to the right */
        }
        .search-container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
        }
        .search-container input {
            width: 300px;
        }
        .navbar-nav {
            align-items: center;  /* Ensures everything stays in the center */
        }

        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
        }

        .navbar-nav .nav-item a {
            padding: 10px 15px;  /* Ensures consistent spacing */
            display: flex;
            align-items: center;
        }

        .btn-custom-green {
            margin-top: 0; /* Ensures buttons align with text */
            padding: 8px 16px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand" href="#">
            <img src="assets/logo-light.png" width="150" height="80" alt="SkillBazaar">
        </a>

        <!-- Search Bar (Centered) -->
        <div class="search-container">
            <div class="input-group">
                <input class="form-control" type="search" placeholder="Search courses..." aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </div>
        </div>

        <!-- Navbar toggler for small screens -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Items (Aligned Right) -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="menuBar" href="MainPage.jsp">Home</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle menuBar" href="#" id="exploreDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Explore
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="exploreDropdown">
                        <li><a class="dropdown-item" href="#">Master JLPT with Java Full Stack</a></li>
                        <li><a class="dropdown-item" href="#">Industrial Internship Programs</a></li>
                        <li><a class="dropdown-item" href="#">JAVA Full Stack</a></li>
                        <li><a class="dropdown-item" href="#">Data Science Using Python</a></li>
                        <li><a class="dropdown-item" href="#">Data Structure</a></li>
                        <li><a class="dropdown-item" href="coreJava.jsp">Core JAVA</a></li>
                        <li><a class="dropdown-item" href="#">Advance JAVA</a></li>
                        <li><a class="dropdown-item" href="#">Python Course</a></li>
                        <li><a class="dropdown-item" href="#">C Course</a></li>
                        <li><a class="dropdown-item" href="#">C++ Course</a></li>
                        <li><a class="dropdown-item" href="#">Japanese N5 Course</a></li>
                    </ul>
                </li>
                <!-- Login and Signup Buttons with Green Color -->
                <li class="nav-item">
                    <a class="btn btn-custom-green mx-2" href="LoginPage.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-custom-green" href="#">Sign Up</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Bootstrap JS (jQuery and Bootstrap Bundle) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

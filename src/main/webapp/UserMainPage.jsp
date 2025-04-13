<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - Learn Anything, Anytime</title>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/logos/favicon.ico">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Slick Slider CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
    <!-- Custom CSS -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F7FA;
            color: #333333;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background-color: #F5F7FA;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .logo img {
            height: 45px;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-links a {
            color: #333333;
            text-decoration: none;
            margin: 0 20px;
            font-size: 16px;
            font-weight: 500;
        }
        .nav-links a:hover {
            color: #00C4B4;
        }
        .auth-buttons {
            display: flex;
            align-items: center;
        }
        .auth-buttons a {
            color: #333333;
            text-decoration: none;
            margin-left: 15px;
            padding: 8px 20px;
            border: 1px solid #00C4B4;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .auth-buttons a:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
        }
        .cart-icon {
            position: relative;
            margin-left: 20px;
        }
        .cart-icon i {
            font-size: 20px;
            color: #333333;
        }
        .cart-icon i:hover {
            color: #00C4B4;
        }
        .cart-count {
            position: absolute;
            top: -10px;
            right: -10px;
            background-color: #00C4B4;
            color: #FFFFFF;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .hero-section {
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(135deg, #F5F7FA 50%, #E0F7FA 100%);
        }
        .hero-section h1 {
            font-size: 48px;
            color: #333333;
            margin-bottom: 20px;
        }
        .hero-section p {
            font-size: 18px;
            color: #666666;
            margin-bottom: 30px;
        }
        .search-bar {
            display: inline-flex;
            align-items: center;
            background-color: #FFFFFF;
            border-radius: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .search-bar input {
            padding: 12px 20px;
            width: 400px;
            border: none;
            border-radius: 25px 0 0 25px;
            outline: none;
            font-size: 16px;
        }
        .search-bar button {
            padding: 12px 30px;
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            border-radius: 0 25px 25px 0;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .search-bar button:hover {
            background-color: #00A89A;
        }
        .categories-section {
            padding: 50px 20px;
            text-align: center;
        }
        .categories-section h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 40px;
        }
        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .category-card {
            background-color: #FFFFFF;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        .category-card:hover {
            transform: translateY(-5px);
        }
        .category-card h3 {
            font-size: 18px;
            color: #333333;
            margin-bottom: 10px;
        }
        .category-card p {
            font-size: 14px;
            color: #666666;
        }
        .popular-courses {
            padding: 50px 20px;
            text-align: center;
        }
        .popular-courses h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 40px;
        }
        .course-slider {
            max-width: 1200px;
            margin: 0 auto;
        }
        .course-card {
            background-color: #FFFFFF;
            border-radius: 10px;
            padding: 15px;
            margin: 0 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        .course-card:hover {
            transform: translateY(-5px);
        }
        .course-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }
        .course-card h3 {
            font-size: 18px;
            color: #333333;
            margin: 10px 0;
        }
        .course-card p {
            font-size: 14px;
            color: #666666;
        }
        .course-card .price {
            color: #00C4B4;
            font-weight: bold;
            margin: 10px 0;
        }
        .course-card .rating {
            color: #00C4B4;
            margin-bottom: 10px;
        }
        .course-card .buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .course-card button {
            background-color: transparent;
            border: 1px solid #00C4B4;
            color: #00C4B4;
            padding: 8px 15px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .course-card button:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
        }
        .tags-section {
            padding: 50px 20px;
            text-align: center;
        }
        .tags-section h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 40px;
        }
        .tag-slider {
            max-width: 1200px;
            margin: 0 auto;
        }
        .tag-card {
            background-color: #FFFFFF;
            border: 1px solid #E0E0E0;
            border-radius: 25px;
            padding: 10px 20px;
            margin: 0 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .tag-card:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
            border-color: #00C4B4;
        }
        .tag-card p {
            font-size: 16px;
            color: #333333;
        }
        .tag-card:hover p {
            color: #FFFFFF;
        }
        .slick-prev, .slick-next {
            font-size: 0;
            line-height: 0;
            position: absolute;
            top: 50%;
            display: block;
            width: 20px;
            height: 20px;
            padding: 0;
            transform: translate(0, -50%);
            cursor: pointer;
            color: transparent;
            border: none;
            outline: none;
            background: transparent;
        }
        .slick-prev:before, .slick-next:before {
            font-size: 20px;
            line-height: 1;
            color: #333333;
            opacity: 0.75;
        }
        .slick-prev {
            left: -25px;
        }
        .slick-next {
            right: -25px;
        }
        footer {
            background-color: #F5F7FA;
            color: #666666;
            text-align: center;
            padding: 20px;
            border-top: 1px solid #E0E0E0;
        }
        footer a {
            color: #00C4B4;
            text-decoration: none;
            margin: 0 10px;
        }
        .project-note {
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="assets/SkillBazaar-logo.png" alt="SkillBazaar Logo">
        </div>
        <div class="nav-links">
            <a href="index.jsp">Courses</a>
            <a href="#">Categories</a>
            <a href="#">For Instructors</a>
            <div class="auth-buttons">
                <a href="login.jsp">Login</a>
                <a href="signup.jsp">Signup</a>
                <div class="cart-icon">
                    <a href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
                    <span class="cart-count">0</span>
                </div>
            </div>
        </div>
    </header>

    <section class="hero-section">
        <h1>Learn Anything, Anytime with SkillBazaar</h1>
        <p>Explore a wide range of courses from top instructors like Prof. Prasad Sase</p>
        <div class="search-bar">
            <input type="text" placeholder="Search for courses...">
            <button>Search</button>
        </div>
    </section>

    <section class="categories-section">
        <h2>Explore Categories</h2>
        <div class="category-grid">
            <div class="category-card">
                <h3>Technology</h3>
                <p>Learn coding, web development, and more.</p>
            </div>
            <div class="category-card">
                <h3>Data Science</h3>
                <p>Master data analysis and machine learning.</p>
            </div>
            <div class="category-card">
                <h3>Business</h3>
                <p>Enhance your business and marketing skills.</p>
            </div>
            <div class="category-card">
                <h3>Design</h3>
                <p>Create stunning designs with expert guidance.</p>
            </div>
        </div>
    </section>

    <section class="popular-courses">
        <h2>Popular Courses</h2>
        <div class="course-slider">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillbazaar", "root", "password");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM courses");
                    while (rs.next()) {
            %>
            <div class="course-card">
                <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("title") %>">
                <h3><%= rs.getString("title") %></h3>
                <p>Instructor: <%= rs.getString("instructor") %></p>
                <p class="price">₹<%= rs.getString("price") %></p>
                <p class="rating">Rating: <%= rs.getString("rating") %> ★</p>
                <div class="buttons">
                    <button onclick="addToCart(<%= rs.getInt("course_id") %>)">Add to Cart</button>
                    <button onclick="window.location.href='courseDetails.jsp?course_id=<%= rs.getInt("course_id") %>'">View Details</button>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </section>

    <section class="tags-section">
        <h2>Browse by Tags</h2>
        <div class="tag-slider">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillbazaar", "root", "password");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM tags");
                    while (rs.next()) {
            %>
            <div class="tag-card" onclick="window.location.href='coursesByTag.jsp?tag_id=<%= rs.getInt("tag_id") %>'">
                <p><%= rs.getString("tag_name") %></p>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </section>

    <footer>
        <p>© 2025 SkillBazaar. All rights reserved.</p>
        <p class="project-note">A project by N-Infinity Info Solutions under the guidance of Prof. Prasad Sase.</p>
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy Policy</a>
    </footer>

    <!-- jQuery and Slick Slider JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.course-slider').slick({
                slidesToShow: 4,
                slidesToScroll: 1,
                autoplay: true,
                autoplaySpeed: 2000,
                prevArrow: '<button type="button" class="slick-prev">Previous</button>',
                nextArrow: '<button type="button" class="slick-next">Next</button>',
                responsive: [
                    {
                        breakpoint: 1024,
                        settings: {
                            slidesToShow: 3
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            slidesToShow: 2
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            slidesToShow: 1
                        }
                    }
                ]
            });

            $('.tag-slider').slick({
                slidesToShow: 6,
                slidesToScroll: 1,
                autoplay: true,
                autoplaySpeed: 3000,
                prevArrow: '<button type="button" class="slick-prev">Previous</button>',
                nextArrow: '<button type="button" class="slick-next">Next</button>',
                responsive: [
                    {
                        breakpoint: 1024,
                        settings: {
                            slidesToShow: 4
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            slidesToShow: 3
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            slidesToShow: 2
                        }
                    }
                ]
            });
        });

        function addToCart(courseId) {
            $.ajax({
                url: 'AddToCartServlet',
                type: 'POST',
                data: { courseId: courseId },
                success: function(response) {
                    if (response === 'success') {
                        alert('Course added to cart!');
                        let cartCount = parseInt($('.cart-count').text());
                        $('.cart-count').text(cartCount + 1);
                    } else {
                        alert('Error adding course to cart.');
                    }
                },
                error: function() {
                    alert('Error adding course to cart.');
                }
            });
        }
    </script>
</body>
</html>
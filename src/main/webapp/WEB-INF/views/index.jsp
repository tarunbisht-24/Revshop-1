<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="base.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.2.0/fonts/remixicon.css" rel="stylesheet"/>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <title>Revshop</title>
    <style>
    @import url("https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap");
    
    .carousel-inner img {
    width: 100%;
    height: 350px;
    object-fit: cover;
    transition: transform 0.5s ease-in-out;
}

/* On hover, carousel images will zoom slightly */
.carousel-inner img:hover {
    transform: scale(1.05);
}

/* Card styles */
.card, .cus-card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

/* Hover effect for card */
.card:hover, .cus-card:hover {
    transform: translateY(-10px) scale(1.02);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

/* Category card hover effect */
.card-body a, .cus-card .card-body a {
    color: #333;
    text-decoration: none;
    font-size: 1rem;
    font-weight: 500;
    transition: color 0.3s ease-in-out;
}

.card-body a:hover, .cus-card .card-body a:hover {
    text-decoration: underline;
    color: #007bff;
}

/* Hover animation for product images */
.card img, .cus-card img {
    width: 100%;
height: auto; /* Adjusted height for product images */
    object-fit: contain; /* Ensure the image scales properly without overflow */
    transition: transform 0.4s ease;
    object-fit: cover;
    transition: transform 0.4s ease;
}

/* On hover, product image zoom effect */
.card img:hover, .cus-card img:hover {
    transform: scale(1.1);
}

/* Category container styles */
.category-container .card {
    border-radius: 50%;
    overflow: hidden;
    transition: transform 0.4s ease-in-out;
}

/* Hover effect on category cards */
.category-container .card:hover {
    transform: scale(1.1) rotate(10deg);
}

.category-container img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 50%;
    transition: transform 0.4s ease-in-out;
}

/* Badge animations */
.badge-discount {
    background-color: #ff5722;
    color: white;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 12px;
    position: absolute;
    top: 10px;
    left: 10px;
    animation: pulse 1.5s infinite;
}

/* Pulse effect for the discount badge */
@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

/* Price styles */
.real-price {
    font-size: 20px;
    font-weight: 600;
    color: #027a3e;
    transition: color 0.4s;
}

.product-price {
    font-size: 17px;
    text-decoration: line-through;
    color: #999;
}

.product-discount {
    font-size: 15px;
    color: #ff5722;
}

/* Hover effect on product prices */
.real-price:hover {
    color: #004d1a;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .card-item {
        flex: 1 1 calc(50% - 1rem);
    }

    .card img, .cus-card img {
        height: 150px;
    }
}

@media (max-width: 576px) {
    .card-item {
        flex: 1 1 100%;
    }

    .card img, .cus-card img {
        height: 120px;
    }
}
    </style>
  </head>
  <body>
    <div class="header__bar">Free Shipping on Orders Over $50</div>

    <header>
      <div class="section__container header__container">
        <div class="header__content">
          <p>EXTRA 55% OFF IN SPRING SALE</p>
          <h1>Discover & Shop<br />The Trend Ss19</h1>
          <button class="btn" onclick="window.location.href='/products'">SHOP NOW</button>
        </div>
        <div class="header__image">
          <img src="${pageContext.request.contextPath}/img/home_img/header.png" alt="header" />
        </div>
      </div>
    </header>

    <section class="section__container collection__container">
      <img src="${pageContext.request.contextPath}/img/home_img/collection.jpg" alt="collection" />
      <div class="collection__content">
        <h2 class="section__title">New Collection</h2>
        <p>NEW ITEMS</p>
        <h4>Available on Store</h4>
        <button class="btn" onclick="window.location.href='/products'">SHOP NOW</button>
      </div>
    </section>

    <section class="section__container sale__container">
      <h2 class="section__title">On Sale</h2>
      <div class="sale__grid">
        <div class="sale__card">
          <img src="${pageContext.request.contextPath}/img/home_img/sale-1.jpg" alt="sale" />
          <div class="sale__content">
            <p class="sale__subtitle">MAN OUTERWEAR</p>
            <h4 class="sale__title">sale <span>40%</span> off</h4>
            <p class="sale__subtitle">- DON'T MISS -</p>
            <button class="btn sale__btn" onclick="window.location.href='/products'">SHOP NOW</button>
          </div>
        </div>
        <div class="sale__card">
          <img src="${pageContext.request.contextPath}/img/home_img/sale-2.jpg" alt="sale" />
          <div class="sale__content">
            <p class="sale__subtitle">WOMAN T-SHIRT</p>
            <h4 class="sale__title">sale <span>25%</span> off</h4>
            <p class="sale__subtitle">- DON'T MISS -</p>
            <button class="btn sale__btn" onclick="window.location.href='/products'">SHOP NOW</button>
          </div>
        </div>
        <div class="sale__card">
          <img src="${pageContext.request.contextPath}/img/home_img/sale-3.jpg" alt="sale" />
          <div class="sale__content">
            <p class="sale__subtitle">JACKETS</p>
            <h4 class="sale__title">sale <span>20%</span> off</h4>
            <p class="sale__subtitle">- DON'T MISS -</p>
            <button class="btn sale__btn" onclick="window.location.href='/products'">SHOP NOW</button>
          </div>
        </div>
      </div>
    </section>
    
          <div class="container mx-auto my-5">
          <div class="text-center mb-8">
              <p class="text-3xl font-semibold">Category</p>
          </div>
          <div class="flex flex-wrap justify-center">
              <c:forEach var="category" items="${categories}">
                  <div class="w-1/4 sm:w-1/3 lg:w-1/6 p-4">
                      <div class="bg-white rounded-full shadow-lg transition-transform transform hover:scale-105">
                          <div class="relative">
                              <img src="${pageContext.request.contextPath}/img/category_img/${category.imageName}"
                                   class="w-full h-auto rounded-full object-cover"
                                   alt="${category.name}">
                          </div>
                          <div class="p-4 text-center">
                              <a href="${pageContext.request.contextPath}/products?category=${category.name}"
                                 class="text-lg font-medium text-gray-800 hover:text-blue-500 transition duration-300">
                                 ${category.name}
                              </a>
                          </div>
                      </div>
                  </div>
              </c:forEach>
          </div>
      </div>

      <section class="section__container musthave__container">
      <h2 class="section__title">Must Have</h2>
      <div class="musthave__nav">
        <a href="/products">ALL</a>
        <a href="/products?ch=men">MEN</a>
        <a href="/products?ch=women">WOMEN</a>
        <a href="/products?ch=bag">BAG</a>
        <a href="/products?ch=shoes">SHOES</a>
      </div>
      <div class="musthave__grid">
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-1.png" alt="must have" />
          <h4>Basic long sleeve T-shirt</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-2.png" alt="must have" />
          <h4>Ribbed T-shirt with buttons</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-3.png" alt="must have" />
          <h4>Jacket withside strips</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-4.png" alt="must have" />
          <h4>High-heel tubular sandals</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-5.png" alt="must have" />
          <h4>Coral fabric belt bag</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-6.png" alt="must have" />
          <h4>Piggy skater slogan T-shirt</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-7.png" alt="must have" />
          <h4>White platform boots</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-8.png" alt="must have" />
          <h4>Sweater vest with sleeves</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-9.png" alt="must have" />
          <h4>Slim fit pants</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-10.png" alt="must have" />
          <h4>Gray backpack</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-11.png" alt="must have" />
          <h4>Neon sweatshirt</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
        <div class="musthave__card">
          <img src="${pageContext.request.contextPath}/img/home_img/musthave-12.png" alt="must have" />
          <h4>Hooded nautical jacket</h4>
          <p><del>Rs. 450</del> Rs. 300</p>
        </div>
      </div>
    </section>

    <section class="news">
      <div class="section__container news__container">
        <h2 class="section__title">Latest News</h2>
        <div class="news__grid">
          <div class="news__card">
            <img src="${pageContext.request.contextPath}/img/home_img/news-1.jpg" alt="news" />
            <div class="news__details">
              <p>
                FASHION <i class="ri-checkbox-blank-circle-fill"></i>
                <span>RYAN REYNOLDS</span>
                <i class="ri-checkbox-blank-circle-fill"></i> SEP 2, 2024
              </p>
              <h4>Seasonal Trends</h4>
              <hr />
              <p>
                Discuss the latest fashion trends for the current season and
                offer tips and ideas on how to incorporate these trends into
                your wardrobe.
              </p>
              <a href="https://www.instyle.com/fashion/seasonal"><i class="ri-arrow-right-line"></i></a>
            </div>
          </div>
          <div class="news__card">
            <img src="${pageContext.request.contextPath}/img/home_img/news-2.jpg" alt="news" />
            <div class="news__details">
              <p>
                TRENDS <i class="ri-checkbox-blank-circle-fill"></i>
                <span>GIGI HADID</span>
                <i class="ri-checkbox-blank-circle-fill"></i> AUG 15, 2024
              </p>
              <h4>Fashion Tips and Advice</h4>
              <hr />
              <p>
                Provide your readers with practical tips and advice on how to
                dress for different occasions, body types, or style preferences.
              </p>
              <a href="https://www.masterclass.com/articles/fashion-tips-to-ensure-you-always-look-stylish"><i class="ri-arrow-right-line"></i></a>
            </div>
          </div>
          <div class="news__card">
            <img src="${pageContext.request.contextPath}/img/home_img/news-3.jpg" alt="news" />
            <div class="news__details">
              <p>
                STYLE <i class="ri-checkbox-blank-circle-fill"></i>
                <span>GISELE BÜNDCHEN</span>
                <i class="ri-checkbox-blank-circle-fill"></i> JUL 22, 2024
              </p>
              <h4>Sustainable Fashion</h4>
              <hr />
              <p>
                Cover the growing trend of eco-conscious fashion and explore the
                various ways to be sustainable in your fashion choices.
              </p>
              <a href="https://www.harpersbazaar.com/uk/fashion/what-to-wear/g19491797/the-best-and-still-chic-sustainable-brands/"><i class="ri-arrow-right-line"></i></a>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section__container brands__container">
      <div class="brand__image">
        <img src="${pageContext.request.contextPath}/img/home_img/brand-1.png" alt="brand" />
      </div>
      <div class="brand__image">
        <img src="${pageContext.request.contextPath}/img/home_img/brand-2.png" alt="brand" />
      </div>
      <div class="brand__image">
        <img src="${pageContext.request.contextPath}/img/home_img/brand-3.png" alt="brand" />
      </div>
      <div class="brand__image">
        <img src="${pageContext.request.contextPath}/img/home_img/brand-4.png" alt="brand" />
      </div>
      <div class="brand__image">
        <img src="${pageContext.request.contextPath}/img/home_img/brand-5.png" alt="brand" />
      </div>
      <div class="brand__image">
        <img src="${pageContext.request.contextPath}/img/home_img/brand-6.png" alt="brand" />
      </div>
    </section>

    <hr />

    <footer class="section__container footer__container">
      <div class="footer__col">
        <h4 class="footer__heading">CONTACT INFO</h4>
        <p>
          <i class="ri-map-pin-2-fill"></i> 12th Floor, Workafella Teynampet Chennai, India
        </p>
        <p><i class="ri-mail-fill"></i> hello@Revature.com</p>
        <p><i class="ri-phone-fill"></i> (+91) 703 570 8181</p>
      </div>
      <div class="footer__col">
        <h4 class="footer__heading">COMPANY</h4>
        <p>Home</p>
        <p>About Us</p>
        <p>Work With Us</p>
        <p>Our Blog</p>
        <p>Terms & Conditions</p>
      </div>
      <div class="footer__col">
        <h4 class="footer__heading">USEFUL LINK</h4>
        <p>Help</p>
        <p>Track My Order</p>
        <p>Men</p>
        <p>Women</p>
        <p>Shoes</p>
      </div>
      <div class="footer__col">
        <h4 class="footer__heading">INSTAGRAM</h4>
        <div class="instagram__grid">
          <img src="${pageContext.request.contextPath}/img/home_img/instagram-1.jpg" alt="instagram" />
          <img src="${pageContext.request.contextPath}/img/home_img/instagram-2.jpg" alt="instagram" />
          <img src="${pageContext.request.contextPath}/img/home_img/instagram-3.jpg" alt="instagram" />
          <img src="${pageContext.request.contextPath}/img/home_img/instagram-4.jpg" alt="instagram" />
          <img src="${pageContext.request.contextPath}/img/home_img/instagram-5.jpg" alt="instagram" />
          <img src="${pageContext.request.contextPath}/img/home_img/instagram-6.jpg" alt="instagram" />
        </div>
      </div>
    </footer>

    <hr />

    <div class="section__container footer__bar">
      <div class="copyright">
        Copyright © 2024 by Technerdz. All rights reserved.
      </div>
      <div class="footer__form">
        <form>
          <input type="text" placeholder="ENTER YOUR EMAIL" />
          <button class="btn" type="submit">SUBSCRIBE</button>
        </form>
      </div>
    </div>
  </body>
</html>

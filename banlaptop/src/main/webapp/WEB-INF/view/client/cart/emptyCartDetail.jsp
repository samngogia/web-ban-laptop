<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Giỏ Hàng Trống - Laptop Shop</title>

    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
      rel="stylesheet"
    />

    <!-- Icons -->
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <!-- Bootstrap 5.3 -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Custom CSS -->
    <link href="/css/client/style.css" rel="stylesheet" />

    <style>
      .empty-cart-section {
        min-height: 70vh;
        display: flex;
        align-items: center;
        background: linear-gradient(
            rgba(255, 255, 255, 0.95),
            rgba(255, 255, 255, 0.95)
          ),
          url("https://images.pexels.com/photos/265658/pexels-photo-265658.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2");
        background-position: center;
        background-size: cover;
      }
      .empty-cart-icon {
        font-size: 5rem;
        color: #adb5bd;
        margin-bottom: 1.5rem;
      }
      .btn-shop-now {
        background-color: #28a745;
        border: none;
        padding: 12px 30px;
        font-size: 1.2rem;
        font-weight: 600;
        border-radius: 50px;
        box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        transition: all 0.3s ease;
      }
      .btn-shop-now:hover {
        background-color: #218838;
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
      }
    </style>
  </head>
  <body>
    <!-- Navbar (tái sử dụng) -->
    <jsp:include page="includes/navbar.jsp" />

    <!-- Empty Cart Message -->
    <section class="empty-cart-section py-5">
      <div class="container">
        <div class="row justify-content-center text-center">
          <div class="col-lg-6 col-md-8">
            <i class="fas fa-shopping-cart empty-cart-icon"></i>
            <h2 class="display-5 fw-bold text-dark mb-4">
              Giỏ Hàng Của Bạn Đang Trống
            </h2>
            <p class="lead text-muted mb-5">
              Có vẻ như bạn chưa thêm sản phẩm nào vào giỏ hàng.<br />
              Hãy khám phá cửa hàng và chọn những chiếc laptop ưng ý ngay hôm
              nay!
            </p>
            <a href="/" class="btn btn-success btn-shop-now text-white">
              <i class="fas fa-store me-2"></i>
              Đi Mua Sắm Ngay
            </a>
            <div class="mt-5">
              <small class="text-muted">
                <i class="fas fa-headset me-2"></i>
                Cần hỗ trợ? Liên hệ chúng tôi qua email hoặc hotline
              </small>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Back to Top Button -->
    <a
      href="#"
      class="btn btn-primary rounded-circle back-to-top border-3"
      style="position: fixed; bottom: 20px; right: 20px; z-index: 99"
    >
      <i class="fa fa-arrow-up"></i>
    </a>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/client/main.js"></script>

    <script>
      // Ẩn spinner nếu có (từ template cũ)
      window.addEventListener("load", () => {
        const spinner = document.getElementById("spinner");
        if (spinner) spinner.classList.remove("show");
      });
    </script>
  </body>
</html>

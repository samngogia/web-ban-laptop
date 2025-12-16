<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Hàng Thành Công - Laptop Shop</title>

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
      .success-section {
        min-height: 100vh;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
      }

      .success-card {
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 3rem 2rem;
        text-align: center;
        max-width: 600px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.2);
      }

      .success-icon {
        font-size: 5rem;
        color: #28a745;
        margin-bottom: 1.5rem;
        animation: bounce 2s infinite;
      }

      @keyframes bounce {
        0%,
        100% {
          transform: translateY(0);
        }
        50% {
          transform: translateY(-20px);
        }
      }

      .btn-continue {
        background-color: #28a745;
        border: none;
        padding: 12px 40px;
        font-size: 1.2rem;
        font-weight: 600;
        border-radius: 50px;
        margin-top: 1.5rem;
        box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        transition: all 0.3s ease;
      }

      .btn-continue:hover {
        background-color: #218838;
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(40, 167, 69, 0.5);
      }

      canvas#confetti {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: 1;
      }
    </style>
  </head>
  <body>
    <!-- Confetti Canvas -->
    <canvas id="confetti"></canvas>

    <!-- Navbar -->
    <jsp:include page="includes/navbar.jsp" />

    <!-- Success Message -->
    <section class="success-section">
      <div class="container position-relative" style="z-index: 2">
        <div class="success-card mx-auto">
          <i class="fas fa-check-circle success-icon"></i>
          <h1 class="display-4 fw-bold mb-4">Đặt Hàng Thành Công!</h1>
          <p class="lead mb-4">
            Cảm ơn bạn đã tin tưởng và mua sắm tại
            <strong>Laptop Shop</strong>.<br />
            Đơn hàng của bạn đã được ghi nhận thành công.
          </p>

          <c:if test="${not empty orderId}">
            <div class="bg-white text-dark rounded-3 p-3 mb-4">
              <p class="mb-1"><strong>Mã đơn hàng:</strong> #${orderId}</p>
              <p class="mb-0">
                <strong>Tổng tiền:</strong>
                <fmt:formatNumber
                  value="${totalAmount}"
                  type="currency"
                  currencySymbol=""
                />
                ₫
              </p>
            </div>
          </c:if>

          <p class="text-white-50 mb-4">
            Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận và
            giao hàng.
          </p>

          <a href="/" class="btn btn-success btn-continue text-white">
            <i class="fas fa-shopping-bag me-2"></i>
            Tiếp Tục Mua Sắm
          </a>

          <div class="mt-4">
            <a
              href="/purcharseHist"
              class="text-white text-decoration-underline small"
            >
              <i class="fas fa-history me-1"></i>Xem lịch sử đơn hàng
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/client/main.js"></script>

    <!-- Confetti Effect - Improved & Cleaned -->
    <script>
      const canvas = document.getElementById("confetti");
      const ctx = canvas.getContext("2d");
      let particles = [];
      const colors = [
        "#f44336",
        "#e91e63",
        "#9c27b0",
        "#673ab7",
        "#3f51b5",
        "#2196f3",
        "#03a9f4",
        "#00bcd4",
        "#009688",
        "#4caf50",
        "#8bc34a",
        "#cddc39",
        "#ffeb3b",
        "#ffc107",
        "#ff9800",
        "#ff5722",
      ];

      function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
      }

      class Particle {
        constructor() {
          this.x = Math.random() * canvas.width;
          this.y = Math.random() * canvas.height - canvas.height;
          this.size = Math.random() * 15 + 10;
          this.speedY = Math.random() * 3 + 2;
          this.speedX = Math.random() * 3 - 1.5;
          this.color = colors[Math.floor(Math.random() * colors.length)];
          this.angle = Math.random() * Math.PI * 2;
          this.spin = Math.random() * 0.1 - 0.05;
        }

        update() {
          this.y += this.speedY;
          this.x += this.speedX;
          this.angle += this.spin;

          if (this.y > canvas.height) {
            this.y = -20;
            this.x = Math.random() * canvas.width;
          }
        }

        draw() {
          ctx.save();
          ctx.translate(this.x, this.y);
          ctx.rotate(this.angle);
          ctx.fillStyle = this.color;
          ctx.fillRect(
            -this.size / 2,
            -this.size / 2,
            this.size,
            this.size / 3
          );
          ctx.restore();
        }
      }

      function initParticles() {
        particles = [];
        const count = window.innerWidth < 768 ? 50 : 120; // Ít hơn trên mobile
        for (let i = 0; i < count; i++) {
          particles.push(new Particle());
        }
      }

      function animate() {
        requestAnimationFrame(animate);
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        particles.forEach((p) => {
          p.update();
          p.draw();
        });
      }

      window.addEventListener("resize", () => {
        resizeCanvas();
        initParticles();
      });

      resizeCanvas();
      initParticles();
      animate();
    </script>
  </body>
</html>

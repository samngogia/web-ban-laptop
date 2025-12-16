<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - Laptop Shop</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Fonts -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="/css/client/lightbox.min.css" rel="stylesheet">
    <link href="/css/client/owl.carousel.min.css" rel="stylesheet">
    <link href="/css/client/style.css" rel="stylesheet">

    <style>
        .quantity-input {
            width: 80px;
        }
        .dropdown-content a {
            font-size: 14px;
            padding: 10px 16px;
        }
        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 99;
        }
    </style>
</head>
<body>
    <!-- Spinner -->
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <!-- Navbar -->
    <div class="container-fluid fixed-top">
        <!-- Topbar -->
        <div class="container topbar bg-primary d-none d-lg-block">
            <div class="d-flex justify-content-between text-white">
                <div>
                    <small><i class="fas fa-map-marker-alt me-2"></i> Tiền Hải, Thái Bình</small>
                    <small class="ms-3"><i class="fas fa-envelope me-2"></i> pxql@gmail.com</small>
                </div>
            </div>
        </div>

        <!-- Main Nav -->
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="/" class="navbar-brand">
                    <h1 class="text-primary display-6 mb-0">Laptop Shop</h1>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav mx-auto">
                        <a href="/" class="nav-item nav-link active">Trang Chủ</a>
                        <a href="/buy" class="nav-item nav-link">Cửa Hàng</a>
                    </div>
                    <div class="d-flex align-items-center m-3">
                        <c:choose>
                            <c:when test="${not empty pageContext.request.userPrincipal}">
                                <!-- Giỏ hàng -->
                                <a href="/cart" class="position-relative me-4">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                          style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                                        ${SumCarts}
                                    </span>
                                </a>

                                <!-- Dropdown tài khoản -->
                                <div class="dropdown">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        <i class="fas fa-user fa-2x"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li class="dropdown-item text-center">
                                            <img src="/images/avatar/1730739674234-but-xoa-Artline-600x600.jpg"
                                                 class="rounded-circle mb-2" width="50" height="50" alt="Avatar">
                                            <div class="small text-muted">${pageContext.request.userPrincipal.name}</div>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="/overView">Quản Lý Tài Khoản</a></li>
                                        <li><a class="dropdown-item" href="/purcharseHist">Lịch Sử Mua Hàng</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <form action="/logout" method="post" class="m-0">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="dropdown-item text-danger">Đăng Xuất</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="btn btn-outline-primary">Đăng nhập</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <!-- Page Header -->
    <div class="container-fluid page-header py-5 text-center text-white">
        <h1 class="display-6">Giỏ Hàng Của Bạn</h1>
    </div>

    <!-- Cart Content -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <c:choose>
                <c:when test="${empty cartDetails}">
                    <div class="text-center py-5">
                        <h3>Giỏ hàng trống</h3>
                        <a href="/buy" class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Sản Phẩm</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Số Lượng</th>
                                <th>Tổng</th>
                                <th>Xóa</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${cartDetails}">
                                <tr>
                                    <td>
                                        <img src="/images/product/${item.products.image}"
                                             class="rounded-circle" width="80" height="80" alt="${item.products.name}">
                                    </td>
                                    <td>${item.products.name}</td>
                                    <td><fmt:formatNumber value="${item.products.price}" type="currency" currencySymbol=""/> VND</td>
                                    <td>
                                        <!-- Form cập nhật số lượng -->
                                        <form action="/update-cart" method="post" class="d-inline">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="hidden" name="id" value="${item.id}"/>
                                            <input type="number" name="quantity" value="${item.quantity}"
                                                   min="1" class="form-control quantity-input text-center" required>
                                            <button type="submit" class="btn btn-sm btn-outline-secondary mt-1">Cập nhật</button>
                                        </form>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.products.price * item.quantity}" type="currency" currencySymbol=""/> VND
                                    </td>
                                    <td>
                                        <form action="/delete-product-from-cart" method="post" class="d-inline">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="hidden" name="id" value="${item.id}"/>
                                            <button type="submit" class="btn btn-danger btn-sm rounded-circle">
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Order Summary -->
                    <div class="row g-4 justify-content-end">
                        <div class="col-lg-5">
                            <div class="bg-light rounded p-4">
                                <h4 class="mb-4">Thông Tin Đơn Hàng</h4>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Tạm tính</span>
                                    <strong><fmt:formatNumber value="${SumM}" type="currency" currencySymbol=""/> VND</strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Giảm giá</span>
                                    <span>0 VND</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3">
                                    <span>Phí vận chuyển</span>
                                    <span>0 VND</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <h5>Tổng cộng</h5>
                                    <h5><fmt:formatNumber value="${SumM}" type="currency" currencySymbol=""/> VND</h5>
                                </div>
                                <form action="/checkout" method="get" class="mt-4">
                                    <button type="submit" class="btn btn-primary w-100 py-3 rounded-pill">
                                        Xác Nhận Đơn Hàng
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer (giữ nguyên hoặc refactor tương tự nếu cần) -->
    <!-- ... (phần footer bạn có thể giữ hoặc tối ưu tương tự) ... -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary rounded-circle back-to-top border-3">
        <i class="fa fa-arrow-up"></i>
    </a>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/client/main.js"></script>

    <script>
        // Ẩn spinner khi trang load xong
        window.addEventListener('load', () => {
            const spinner = document.getElementById('spinner');
            if (spinner) {
                spinner.classList.remove('show');
            }
        });
    </script>
</body>
</html>

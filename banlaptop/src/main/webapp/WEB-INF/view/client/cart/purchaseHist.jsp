<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laptop Shop - Chi tiết đơn hàng</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Fonts -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries CSS -->
    <link href="/css/client/lightbox.min.css" rel="stylesheet">
    <link href="/css/client/owl.carousel.min.css" rel="stylesheet">

    <!-- Bootstrap & Template CSS -->
    <link href="/css/client/bootstrap.min.css" rel="stylesheet">
    <link href="/css/client/style.css" rel="stylesheet">

    <style>
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        .total-price {
            font-size: 1.4rem;
            font-weight: 600;
            color: #198754;
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
            <div class="d-flex justify-content-between">
                <div class="top-info ps-2">
                    <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i>
                        <a href="#" class="text-white">Tiền Hải, Thái Bình</a></small>
                    <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i>
                        <a href="mailto:pxql@gmail.com" class="text-white">pxql@gmail.com</a></small>
                </div>
            </div>
        </div>

        <!-- Main Navbar -->
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="/" class="navbar-brand">
                    <h1 class="text-primary display-6">Laptop Shop</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto">
                        <a href="/" class="nav-item nav-link">Trang Chủ</a>
                        <a href="/shop" class="nav-item nav-link">Cửa Hàng</a>
                    </div>

                    <div class="d-flex align-items-center m-3">
                        <c:choose>
                            <c:when test="${not empty pageContext.request.userPrincipal}">
                                <!-- Giỏ hàng -->
                                <a href="/cart" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                          style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                                        ${SumCarts}
                                    </span>
                                </a>

                                <!-- Dropdown User -->
                                <div class="dropdown">
                                    <a class="btn dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                                        <img src="/images/avatar/default-avatar.jpg" alt="Avatar" class="user-avatar me-2">
                                        <span class="d-none d-lg-block">${pageContext.request.userPrincipal.name}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li class="dropdown-item text-center mb-2">
                                            <img src="/images/avatar/default-avatar.jpg" alt="Avatar" class="user-avatar">
                                            <div class="mt-1 small text-muted">${pageContext.request.userPrincipal.name}</div>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="/account">Quản Lý Tài Khoản</a></li>
                                        <li><a class="dropdown-item" href="/order-history">Lịch Sử Mua Hàng</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <form action="/logout" method="post" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="dropdown-item text-danger">Đăng Xuất</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="btn btn-outline-primary px-4">Đăng Nhập</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <!-- Page Header -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Chi Tiết Đơn Hàng</h1>
    </div>

    <!-- Order Details Content -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <!-- Thông tin đơn hàng (nếu có) -->
            <div class="row mb-4">
                <div class="col-12">
                    <h4>Mã đơn hàng: #${order.id} <span class="badge bg-success ms-3">${order.status}</span></h4>
                    <p class="text-muted">Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${orderDetails}">
                            <tr>
                                <td>
                                    <img src="/images/product/${item.products.image}"
                                         class="rounded" style="width: 80px; height: 80px; object-fit: cover;" alt="${item.products.name}">
                                </td>
                                <td class="fw-medium">${item.products.name}</td>
                                <td><fmt:formatNumber value="${item.products.price}" type="currency" currencySymbol=""/> ₫</td>
                                <td class="text-center">${item.quantity}</td>
                                <td class="text-end fw-bold">
                                    <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol=""/> ₫
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="text-end fw-bold">Tổng cộng:</td>
                            <td class="text-end total-price">
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol=""/> ₫
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div class="text-end mt-4">
                <a href="/order-history" class="btn btn-outline-secondary px-4">← Quay lại lịch sử</a>
            </div>
        </div>
    </div>

    <!-- Footer (giữ nguyên hoặc include nếu bạn có footer.jsp) -->
    <!-- ... Footer code có thể include riêng ... -->

    <!-- JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/client/easing.min.js"></script>
    <script src="/js/client/waypoints.min.js"></script>
    <script src="/js/client/lightbox.min.js"></script>
    <script src="/js/client/owl.carousel.min.js"></script>
    <script src="/js/client/main.js"></script>

    <!-- Ẩn spinner khi load xong -->
    <script>
        window.addEventListener('load', () => {
            document.getElementById('spinner').classList.remove('show');
        });
    </script>
</body>
</html>

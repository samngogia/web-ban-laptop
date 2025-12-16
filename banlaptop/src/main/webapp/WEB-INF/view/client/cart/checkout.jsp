<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Laptop Shop</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/css/client/style.css" rel="stylesheet">

    <style>
        .checkout-banner {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.pexels.com/photos/2876787/pexels-photo-2876787.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
            background-position: center;
            background-size: cover;
            height: 40vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
        }
        .summary-card {
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .btn-checkout {
            background-color: #4c616b;
            color: white;
            font-weight: 600;
            padding: 12px;
            border-radius: 8px;
            transition: background-color 0.3s;
        }
        .btn-checkout:hover {
            background-color: #5f7986;
            color: white;
        }
    </style>
</head>
<body>

<!-- Navbar (giống trang giỏ hàng) -->
<jsp:include page="includes/navbar.jsp" />

<!-- Page Header -->
<div class="checkout-banner">
    <h1 class="display-5 fw-bold">Xác Nhận Thanh Toán</h1>
</div>

<!-- Checkout Content -->
<div class="container py-5">
    <div class="row g-5">
        <!-- Left: Order Summary -->
        <div class="col-lg-7">
            <div class="bg-white p-4 summary-card">
                <h4 class="mb-4">Chi Tiết Đơn Hàng</h4>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>Sản Phẩm</th>
                            <th>Tên</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Thành Tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${cartDetails}">
                            <tr>
                                <td>
                                    <img src="/images/product/${item.products.image}"
                                         class="product-img" alt="${item.products.name}">
                                </td>
                                <td class="fw-medium">${item.products.name}</td>
                                <td><fmt:formatNumber value="${item.products.price}" type="currency" currencySymbol=""/> ₫</td>
                                <td class="text-center">${item.quantity}</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${item.products.price * item.quantity}" type="currency" currencySymbol=""/> ₫
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <hr>

                <div class="d-flex justify-content-between py-2">
                    <span>Tạm tính</span>
                    <strong><fmt:formatNumber value="${sums}" type="currency" currencySymbol=""/> ₫</strong>
                </div>
                <div class="d-flex justify-content-between py-2">
                    <span>Chiết khấu</span>
                    <span>0 ₫</span>
                </div>
                <div class="d-flex justify-content-between py-2">
                    <span>Phí vận chuyển</span>
                    <span>Miễn phí</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between py-3">
                    <h5 class="fw-bold">Tổng cộng</h5>
                    <h5 class="text-primary fw-bold">
                        <fmt:formatNumber value="${sums}" type="currency" currencySymbol=""/> ₫
                    </h5>
                </div>
                <div class="alert alert-info small">
                    <i class="fas fa-truck me-2"></i>
                    Hình thức thanh toán: <strong>Thanh toán khi nhận hàng (COD)</strong>
                </div>
            </div>
        </div>

        <!-- Right: Shipping Info Form -->
        <div class="col-lg-5">
            <div class="bg-white p-4 summary-card">
                <h4 class="mb-4">Thông Tin Nhận Hàng</h4>

                <form:form action="/create/order" method="post" modelAttribute="UserInfRec" class="needs-validation" novalidate="true">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="mb-3">
                        <label class="form-label fw-medium">Họ và tên <span class="text-danger">*</span></label>
                        <form:input path="receiverName" class="form-control" required="true" placeholder="Nguyễn Văn A"/>
                        <form:errors path="receiverName" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-medium">Số điện thoại <span class="text-danger">*</span></label>
                        <form:input path="receiverPhone" class="form-control" required="true" placeholder="0901234567"/>
                        <form:errors path="receiverPhone" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-medium">Địa chỉ nhận hàng <span class="text-danger">*</span></label>
                        <form:input path="receiverAddress" class="form-control" required="true"
                                    placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành"/>
                        <form:errors path="receiverAddress" cssClass="text-danger small"/>
                    </div>

                    <button type="submit" class="btn btn-checkout w-100">
                        <i class="fas fa-lock me-2"></i>
                        Xác Nhận Đặt Hàng
                    </button>

                    <p class="text-center text-muted small mt-3">
                        <i class="fas fa-shield-alt me-1"></i>
                        Thông tin của bạn được bảo mật hoàn toàn
                    </p>
                </form:form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="includes/footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary rounded-circle back-to-top border-3" style="position: fixed; bottom: 20px; right: 20px; z-index: 99;">
    <i class="fa fa-arrow-up"></i>
</a>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/client/main.js"></script>

<!-- Form Validation Bootstrap -->
<script>
    // Bootstrap form validation
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    :root {
        --cw-color-primary: #74db34;
        --cw-color-primary-dark: #2980b9;
        --cw-color-primary-light: #ebf5fb;
        --cw-color-secondary: #2ecc71;
        --cw-color-secondary-dark: #27ae60;
        --cw-color-background: #f9f9f9;
        --cw-color-surface: #ffffff;
        --cw-color-text: #333333;
        --cw-color-text-light: #777777;
        --cw-color-border: #e0e0e0;
        --cw-shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.1);
        --cw-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        --cw-shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
    }

    .cw-body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--cw-color-background);
        color: var(--cw-color-text);
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }

    .cw-hero {
        background: linear-gradient(135deg, var(--cw-color-primary) 0%, var(--cw-color-primary-dark) 100%);
        color: var(--cw-color-surface);
        padding: 4rem 2rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .cw-hero::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffffff' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
        opacity: 0.5;
    }

    .cw-hero-title {
        font-size: 3.5rem;
        font-weight: 700;
        margin-bottom: 1rem;
        position: relative;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
    }

    .cw-hero-subtitle {
        font-size: 1.25rem;
        opacity: 0.9;
        max-width: 600px;
        margin: 0 auto;
        position: relative;
    }

    .cw-container {
        max-width: 1200px;
        margin: -3rem auto 2rem;
        padding: 0 2rem;
        position: relative;
    }

    .cw-search-panel {
        background-color: var(--cw-color-surface);
        border-radius: 1rem;
        box-shadow: var(--cw-shadow-lg);
        padding: 2rem;
        margin-bottom: 3rem;
        border: 1px solid var(--cw-color-primary-light);
        transition: all 0.3s ease;
    }

    .cw-search-panel:hover {
        transform: translateY(-5px);
        box-shadow: var(--cw-shadow-lg), 0 10px 25px rgba(52, 152, 219, 0.2);
    }

    .cw-search-form {
        display: grid;
        grid-template-columns: 1fr auto;
        gap: 1.5rem;
        align-items: end;
    }

    .cw-form-group {
        position: relative;
    }

    .cw-senior-info {
        background-color: var(--cw-color-primary-light);
        padding: 1.5rem;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
        text-align: center;
        transition: all 0.3s ease;
    }

    .cw-senior-info:hover {
        box-shadow: var(--cw-shadow);
    }

    .cw-senior-info-title {
        color: var(--cw-color-primary-dark);
        font-size: 1.5rem;
        margin: 0;
        font-weight: 600;
    }

    .cw-form-label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: var(--cw-color-text);
        font-size: 0.95rem;
    }

    .cw-form-control {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 2px solid var(--cw-color-border);
        border-radius: 0.5rem;
        font-size: 1rem;
        transition: all 0.3s ease;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%233498db'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 0.75rem center;
        background-size: 1rem;
        padding-right: 2.5rem;
    }

    .cw-form-control:focus {
        outline: none;
        border-color: var(--cw-color-primary);
        box-shadow: 0 0 0 3px var(--cw-color-primary-light);
    }

    .cw-btn {
        padding: 0.75rem 2rem;
        border: none;
        border-radius: 0.5rem;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .cw-btn-primary {
        background-color: #2ecc71;
        color: var(--cw-color-surface);
    }

    .cw-btn-primary:hover {
        background-color: #27ae60;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(46, 204, 113, 0.3);
    }



    .cw-careworker-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 2rem;
    }

    .cw-careworker-card {
        background-color: var(--cw-color-surface);
        border-radius: 1rem;
        overflow: hidden;
        transition: all 0.3s ease;
        border: 1px solid var(--cw-color-border);
    }

    .cw-careworker-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--cw-shadow-lg);
        border-color: var(--cw-color-primary-light);
    }

    .cw-careworker-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        transition: all 0.3s ease;
    }

    .cw-careworker-card:hover .cw-careworker-image {
        transform: scale(1.05);
    }

    .cw-careworker-info {
        padding: 1.5rem;
    }

    .cw-careworker-name {
        font-size: 1.25rem;
        font-weight: 700;
        margin-bottom: 1rem;
        color: var(--cw-color-primary-dark);
    }

    .cw-careworker-details {
        display: grid;
        gap: 0.5rem;
        font-size: 0.95rem;
        color: var(--cw-color-text-light);
        margin-bottom: 1.5rem;
    }

    .cw-careworker-details span {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .cw-btn-secondary {
        display: block;
        width: 100%;
        text-align: center;
        background-color: var(--cw-color-secondary);
        color: var(--cw-color-surface);
        text-decoration: none;
        padding: 0.75rem;
        border-radius: 0.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .cw-btn-secondary:hover {
        background-color: var(--cw-color-secondary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(46, 204, 113, 0.3);
    }

    @media (max-width: 768px) {
        .cw-hero {
            padding: 3rem 1rem;
        }

        .cw-hero-title {
            font-size: 2.5rem;
        }

        .cw-hero-subtitle {
            font-size: 1rem;
        }

        .cw-container {
            padding: 0 1rem;
            margin-top: -2rem;
        }

        .cw-search-form {
            grid-template-columns: 1fr;
        }

        .cw-form-group {
            margin-bottom: 1rem;
        }

        .cw-btn {
            width: 100%;
        }
    }
</style>

<div class="cw-hero">
    <h1 class="cw-hero-title">근처 보호사 찾기</h1>
    <p class="cw-hero-subtitle">당신의 지역에서 신뢰할 수 있는 보호사를 찾아보세요</p>
</div>

<div class="cw-container">
    <div class="cw-search-panel">
        <div class="cw-senior-info">
            <h2 class="cw-senior-info-title">${senior.seniorName} 시니어</h2>
            <input type="hidden" id="senior-info" value="${senior.seniorId},${senior.seniorLatitude},${senior.seniorLongitude}">
        </div>

        <form class="cw-search-form">
            <div class="cw-form-group">
                <label for="radius-select" class="cw-form-label">검색 반경</label>
                <select id="radius-select" class="cw-form-control">
                    <option value="1">1 km</option>
                    <option value="3">3 km</option>
                    <option value="5" selected>5 km</option>
                    <option value="10">10 km</option>
                    <option value="20">20 km</option>
                </select>
            </div>

            <div class="cw-form-group">
                <button type="button" id="search-btn" class="cw-btn cw-btn-primary">
                    보호사 검색
                </button>
            </div>
        </form>
    </div>
    <div id="careworker-list" class="cw-careworker-list"></div>
</div>

<script src="/js/careworker.js"></script>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    :root {
        --senior-color-primary: #74db34;
        --senior-color-primary-dark: #2980b9;
        --senior-color-primary-light: #ebf5fb;
        --senior-color-secondary: #2ecc71;
        --senior-color-secondary-dark: #27ae60;
        --senior-color-background: #f9f9f9;
        --senior-color-surface: #ffffff;
        --senior-color-text: #333333;
        --senior-color-text-light: #777777;
        --senior-color-border: #e0e0e0;
        --senior-shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.1);
        --senior-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        --senior-shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
    }

    .senior-page {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--senior-color-background);
        color: var(--senior-color-text);
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }

    .senior-hero {
        background: linear-gradient(135deg, var(--senior-color-primary) 0%, var(--senior-color-primary-dark) 100%);
        color: var(--senior-color-surface);
        padding: 4rem 2rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .senior-hero::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffffff' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
        opacity: 0.5;
    }

    .senior-hero-title {
        font-size: 3.5rem;
        font-weight: 700;
        margin-bottom: 1rem;
        position: relative;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
    }

    .senior-container {
        max-width: 1200px;
        margin: -3rem auto 2rem;
        padding: 0 2rem;
        position: relative;
    }

    .senior-list-panel {
        background-color: var(--senior-color-surface);
        border-radius: 1rem;
        box-shadow: var(--senior-shadow-lg);
        padding: 2rem;
        margin-bottom: 3rem;
        border: 1px solid var(--senior-color-primary-light);
        transition: all 0.3s ease;
    }

    .senior-list-panel:hover {
        transform: translateY(-5px);
        box-shadow: var(--senior-shadow-lg), 0 10px 25px rgba(52, 152, 219, 0.2);
    }

    .senior-summary {
        background-color: var(--senior-color-primary-light);
        padding: 1.5rem;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
        text-align: center;
        transition: all 0.3s ease;
    }

    .senior-summary:hover {
        box-shadow: var(--senior-shadow);
    }

    .senior-summary-title {
        color: var(--senior-color-primary-dark);
        font-size: 1.5rem;
        margin: 0;
        font-weight: 600;
    }

    .senior-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 2rem;
    }

    .senior-card {
        background-color: var(--senior-color-surface);
        border-radius: 1rem;
        overflow: hidden;
        transition: all 0.3s ease;
        border: 1px solid var(--senior-color-border);
    }

    .senior-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--senior-shadow-lg);
        border-color: var(--senior-color-primary-light);
    }

    .senior-image {
        width: 100%;
        height: 300px;
        object-fit: cover;
        transition: all 0.3s ease;
    }

    .senior-card:hover .senior-image {
        transform: scale(1.05);
    }

    .senior-details {
        padding: 1.5rem;
    }

    .senior-name {
        font-size: 1.25rem;
        font-weight: 700;
        margin-bottom: 1rem;
        color: var(--senior-color-primary-dark);
    }

    .senior-info {
        display: grid;
        gap: 0.5rem;
        font-size: 0.95rem;
        color: var(--senior-color-text-light);
        margin-bottom: 1.5rem;
    }

    .senior-info span {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .senior-action-btn {
        display: block;
        width: 100%;
        text-align: center;
        background-color: var(--senior-color-secondary);
        color: var(--senior-color-surface);
        text-decoration: none;
        padding: 0.75rem;
        border-radius: 0.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .senior-action-btn:hover {
        background-color: var(--senior-color-secondary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(46, 204, 113, 0.3);
    }

    @media (max-width: 768px) {
        .senior-hero {
            padding: 3rem 1rem;
        }

        .senior-hero-title {
            font-size: 2.5rem;
        }

        .senior-container {
            padding: 0 1rem;
            margin-top: -2rem;
        }
    }
</style>
<div class="senior-page">
    <div class="senior-hero">
        <h1 class="senior-hero-title">시니어케어 동반자</h1>
    </div>

    <div class="senior-container">
        <div class="senior-list-panel">
            <div class="senior-summary">
                <h2 class="senior-summary-title">함께하는 어르신 목록</h2>
            </div>
            <div class="senior-grid">
                <c:forEach var="details" items="${contractsWithDetails}">
                    <div class="senior-card">
                        <img src="/imgs/careworker/${details.senior.seniorProfile}" class="senior-image"
                             alt="${details.senior.seniorName}" onerror="this.src='/imgs/default-profile.jpg'">
                        <div class="senior-details">
                            <h3 class="senior-name">${details.senior.seniorName}</h3>
                            <div class="senior-info">
                                <span><strong>거리:</strong> ${details.distance} km</span>
                                <span><strong>연락처:</strong> ${details.senior.seniorTel}</span>
                            </div>
                            <a href="/careworker/seniors/detail?contractId=${details.contract.contractId}" class="senior-action-btn">상세정보</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<#import "blocks/templates.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Поиск товаров</h1><hr>
    <form method="get" action="/">
        <div class="form-row">
            <div class="form-group col-md-2">
                <label for="searchCity">Город</label>
                <select id="searchCity" class="form-control">
                    <option value="">Город не выбран</option>
                    <option value="Kharkiv">Kharkiv</option>
                    <option value="Kyiv">Kyiv</option>
                    <option value="Lviv">Lviv</option>
                </select>
            </div>
            <div class="form-group col-md-10">
                <label for="searchWord">Поиск по объявлениям</label>
                <input type="text" name="searchWord" class="form-control" id="searchWord">
            </div>
        </div>
        <div class="filter-panel">
            <h2>Фильтр по цене</h2>
            <div class="price-range-slider">
                <label for="minPrice">Минимальная цена:</label>
                <input type="number" id="minPrice" name="minPrice" min="0">
                <label for="maxPrice">Максимальная цена:</label>
                <input type="number" id="maxPrice" name="maxPrice" min="0">
            </div>
            <button type="button" id="filterButton">Применить фильтр</button>
        </div>
        <button style="width: 100%" type="submit" class="btn btn-dark">Поиск</button>
    </form>
    <hr>
    <div class="card-columns">
        <#list products as product>
            <a href="/product/${product.id}" class="product-link">
                <div class="card text-white bg-dark my-3 product">
                    <img src="/images/${product.previewImageId}" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">${product.title}</h5>
                        <p class="card-text">${product.price} ₴</p>
                    </div>
                    <div class="card-footer">
                        ${product.city}
                    </div>
                </div>
            </a>
        <#else>
            <h1 style="text-align: center">Не найдено</h1>
        </#list>
    </div>
    <script>const minPriceInput = document.getElementById('minPrice');
        const maxPriceInput = document.getElementById('maxPrice');
        const filterButton = document.getElementById('filterButton');
        const productCards = document.querySelectorAll('.product-link');

        filterButton.addEventListener('click', filterProducts);

        function filterProducts() {
            const minPrice = parseFloat(minPriceInput.value) || 0;
            const maxPrice = parseFloat(maxPriceInput.value) || Infinity;

            productCards.forEach(card => {
                const productPrice = parseFloat(card.querySelector('.card-text').textContent.replace('₴', ''));
                if (productPrice >= minPrice && productPrice <= maxPrice) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</@t.template>
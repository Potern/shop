<#import "blocks/templates.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Авторизация</h1>
    <hr>
    <form action="/login" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input type="email" class="form-control" id="email" name="username" required>
            <div id="email-invalid" class="invalid-feedback">
                Неверная электронная почта
            </div>
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" class="form-control" id="password" name="password" maxlength="20" required>
            <div id="password-invalid" class="invalid-feedback">
                Пароль должен быть не длиннее 20 символов
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" style="width: 100%" class="btn btn-dark">Войти</button>
    </form>
    <hr>
    <h2>Нет аккаунта MisShop? <a href="/registration">Зарегистрируйся!</a></h2>

    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            if (password.length > 20) {
                document.getElementById("password-invalid").style.display = "block";
                return false;
            } else {
                document.getElementById("password-invalid").style.display = "none";
            }
            return true;
        }
    </script>
</@t.template>

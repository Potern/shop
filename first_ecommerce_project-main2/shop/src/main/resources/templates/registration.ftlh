<#import "blocks/templates.ftlh" as t>
<@t.template user>
<h1 style="text-align: center">Регистрация</h1>
<hr>
<form action="/registration" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
    <div class="form-group">
        <label for="profilePicture">Фото профиля</label>
        <input type="file" class="form-control-file" id="profilePicture" name="profilePicture">
    </div>
    <div class="form-group">
        <label for="name">Имя пользователя</label>
        <input type="text" class="form-control" required id="name" name="name">
    </div>
    <div class="form-group">
        <label for="email">Электронная почта</label>
        <input type="email" class="form-control" id="email" required name="email">
    </div>
    <div class="form-group">
        <label for="phoneNumber">Номер телефона</label>
        <input type="text" class="form-control" id="phoneNumber" required name="phoneNumber">
    </div>
    <div class="form-group">
        <label for="password">Пароль</label>
        <input type="password" class="form-control" id="password" required name="password" maxlength="20">
        <div id="password-invalid" class="invalid-feedback"> Пароль должен быть не длиннее 20 символов </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <button type="submit" style="width: 100%" class="btn btn-dark">Зарегистрироваться</button>
</form>
<#if errorMessage??>
    <h2 style="color: red">${errorMessage}</h2>
</#if>

</@t.template>

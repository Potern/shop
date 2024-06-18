<#import "blocks/templates.ftlh" as t>

<@t.template user>

<h1>Редактирование пользователя ${user.name}</h1>
<hr>

<form action="/admin/user/edit" method="post">

    <#list roles as role>
        <div class="radio">
            <label>
                <input type="radio" name="role" value="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                ${role}
            </label>
        </div>
    </#list>

    <input type="hidden" value="${user.id}" name="userId">
    <input type="hidden" value="${_csrf.token}" name="_csrf">
    <button type="submit" class="btn btn-dark">Сохранить</button>

</form>

</@t.template>

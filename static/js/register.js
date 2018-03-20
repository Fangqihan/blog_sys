
// 注册验证
$('#ajax_register_btn').click(function () {
    $.ajax({
        url: '/register/',
        type: 'post',
        data: $('.register_post_form').serialize(),
        success: function (data) {
            if(data.status=='success'){
                window.location = '{% url "login" %}'
            }
            else if(data.status=='fail'){
                // 接受视图函数传过来的表单错误信息
                $('#username_err').text(data.form_errors.username[0]);
                $('#pwd1_err').text(data.form_errors.password1[0]);
                $('#pwd2_err').text(data.form_errors.password2[0]);
                $('#email_err').text(data.form_errors.email[0]);
                $('#valid_code_err').text(data.form_errors.valid_code[0]);
            }
        }
    })

});
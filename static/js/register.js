
// 注册验证
$('#ajax_register_btn').click(function () {
    $.ajax({
        url: '/register/',
        type: 'post',
        data: $('.register_post_form').serialize(),
        success: function (data) {
            if(data.status=='success'){
                window.location = '/login/'
            }
            else if(data.status=='form_fail'){
                // 接受视图函数传过来的表单错误信息
                // console.log(data);

                if(data.form_errors.username){
                    $('#username_err').text(data.form_errors.username[0]);
                }

                if(data.form_errors.password1){
                    $('#pwd1_err').text(data.form_errors.password1[0]);
                }

                if(data.form_errors.password2){
                    $('#pwd2_err').text(data.form_errors.password2[0]);
                }
                if(data.form_errors.email){
                    $('#email_err').text(data.form_errors.email[0]);
                }
                if(data.form_errors.valid_code){
                    $('#valid_code_err').text(data.form_errors.valid_code[0]);
                }

            }


            else if(data.status == 'logic_fail'){
                // 接受错误逻辑信息
                console.log(data.error_msg, typeof data.error_msg);
                $('#username_err').text(data.error_msg.username);
                $('#pwd2_err').text(data.error_msg.password);
                $('#email_err').text(data.error_msg.email);
                $('#valid_code_err').text(data.error_msg.valid_code);
            }
        }
    })

});
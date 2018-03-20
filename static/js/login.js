// 验证码刷新
$('.refersh').click(function () {
    // 取到img标签的DOM对象
    $('.valid_img')[0].src+='?'

});

$('.left_menu_second_title').mouseover(function () {
    $(this).siblings().removeClass('hide').parent().siblings().children('.list-group-item').addClass('hide');

});







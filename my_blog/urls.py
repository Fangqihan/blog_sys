# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com
from django.conf.urls import url
from my_blog import views


urlpatterns = [
    # 方式1、常规评论，在子评论上方追加父评论内容
    # url(r'^p/(\d{1,5})/', views.article_detail, name='article'),

    # 方式2、利用树形结构评论的文章详情页
    # url(r'^p/(\d{1,5})/', views.article_detail_2, name='article'),

    # 方式3、运用自定义标签在前端渲染评论
    url(r'^p/(\d{1,5})/', views.article_detail_page, name='article'),

    url(r'^favor/', views.user_favor, name='user_favor'),
    url(r'^comment/favor/', views.comment_favor, name='comment_favor'),
    url(r'^comment/', views.user_comment, name='user_comment'),

    # 注意必须放在最后,全能匹配

    # 个人主页/文章分类/标签分类
    # url(r'^(\S+)/$', views.user_page, name='user_page'),
    url(r'^(?P<site>.*)/home/$', views.user_page, name='user_site'),

]
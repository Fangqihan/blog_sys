"""blog_sys URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.views.static import serve

from my_blog import views
from blog_sys import settings

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^login/', views.my_login, name='login'),
    url(r'^logout/', views.my_logout, name='logout'),

    # 主页面
    url(r'^index/$', views.index, name='index'),
    url(r'^$', views.index, name='index'),

    url(r'^captcha/', views.get_valid_img, name='get_valid_img'),
    url(r'^register/', views.register, name='register'),
    url(r'^reset_pwd/', views.reset_pwd, name='reset_pwd'),
    url(r'fans_for/', views.fans_for, name='fans_for'),

    # 文章详情页面
    url(r'^blog/p/(\d{1,5})/', views.text_page),

    # 个人主页
    url(r'^blog/favor/', views.user_favor, name='user_favor'),
    url(r'^blog/comment/favor/', views.comment_favor, name='comment_favor'),
    url(r'^blog/comment/', views.user_comment, name='user_comment'),

    # url(r'^(\d+)//', views.user_filter_page),  # http://localhost:8800/bob/cate/html%E5%9F%BA%E7%A1%80/

    # 注意必须放在最后,全能匹配
    url(r'^blog/(\S+)/', views.user_page, name='user_page'),
]

urlpatterns += [
    url(r'^media/(?P<path>.*)$', serve, {
        'document_root': settings.MEDIA_ROOT,
    }),
]

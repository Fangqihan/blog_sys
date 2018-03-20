from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
import json

from django.shortcuts import render, HttpResponse, redirect
from django.contrib import auth
from django.views.generic.base import View

from my_blog.models import *
from .utils import generate_code, get_random_color
from .forms import RegisterForm


def my_login(request):
    if request.method == "POST":
        # 1,从session中获取本次请求生成的图片代码
        code = request.session.get("valid_code", '').upper()
        # 2. 获取用户提交的数据
        username = request.POST.get('username',"")
        pwd = request.POST.get('password',"")
        valid_code = request.POST.get('valid_code',"")
        # 3. 判断验证码是否合格
        if valid_code.upper() != code:
            return HttpResponse(json.dumps({'status': "fail", 'msg': '验证码有误', 'user':None}),
                                content_type="application/json")
        # 4. 根据用户名和密码从数据库查询匹配的用户
        print(UserInfo.objects.all())
        user = auth.authenticate(username=username, password=pwd)
        if user:
            print(user)
            # 5. 找到用户,则创建或修改session信息, 修改为登录状态
            auth.login(request, user)
            username = user.username

            return HttpResponse(json.dumps({'status': "success", 'msg': '', 'user':username}),
                                content_type="application/json")
        else:
            return HttpResponse(json.dumps({'status': "fail", 'msg': '用户名或密码错误', 'user': None}),
                                content_type="application/json")
    else:
        return render(request, 'login.html')


def get_valid_img(request):
    """获取验证码图片"""

    # 图片验证码逻辑推导过程
    # 方式1: 有很大的局限性, 只能返回固定的图片, 而且图片不可能是随机和无限多的!======

    # 步骤1, 确定图片
    # import os
    # path = os.path.join(settings.BASE_DIR, 'static/img/fang.jpg')
    # f = open(path, 'rb')
    #
    # # 步骤2,读取数据并返回给请求的img标签
    # data = f.read()


    # 方式2: 生成图片后都要保存到本地磁盘=======================================
    # from PIL import Image
    # from random import randint
    # # 1. 生成图片
    # # 颜色随机
    # img = Image.new(mode="RGB", size=(213, 35), color=(randint(0, 255), randint(0, 255), randint(0, 255)))
    #
    # # 2. 保存到本地
    # f = open("a.png", 'wb')
    # img.save(f, 'png')
    #
    # # 3. 读取图片
    # with open('a.png', 'rb') as f:
    #     data = f.read()


    # 方式3: 与方式2相似,区别是将图片读取到内存===================================
    # from PIL import Image
    # from random import randint
    # from io import BytesIO
    # # 1. 生成图片
    # # 颜色随机
    # img = Image.new(mode="RGB", size=(213, 35), color=(randint(0, 255), randint(0, 255), randint(0, 255)))
    #
    # # 2. 保存到内存
    # f = BytesIO()
    # img.save(f, 'png')
    #
    # # 3. 读取图片
    # data = f.getvalue()


    # 方式4: 增加文字=========================================================
    code = generate_code()
    request.session['valid_code'] = code

    # 1. 生成图片
    # 颜色随机
    img = Image.new(mode="RGB", size=(213, 35), color=get_random_color())

    draw = ImageDraw.Draw(img, mode='RGB')   # 生成绘板对象
    # 2. 向图片写入内容
    font = ImageFont.truetype("static/fonts/kumo.ttf", 36)  # 字体样式必须引入, 字体大小
    # 保证每次生成不同的问题,且位数保证6位

    draw.text([60, 0], code, color=get_random_color(), font=font)  # 参数,:坐标, 文字, 颜色, 字体样式

    # 3. 保存到内存
    f = BytesIO()
    img.save(f, 'png')

    # 4. 读取图片
    data = f.getvalue()

    #  方式5, 验证码更新,必须是局部刷新,点击刷新
    return HttpResponse(data)


def index(request):
    """主页面逻辑代码"""
    all_articles = Article.objects.all()

    # 根据网站分类属性筛选文章
    # 1. 获取前端点击的标签名称
    cate_detail = request.GET.get('cate')
    # 2. 根据标签名称取到其id或者对象
    cate_detail_obj = SiteCateDetail.objects.filter(title=cate_detail)
    if cate_detail_obj:
        cate_detail_obj = cate_detail_obj.first()

    if cate_detail:
        all_articles = Article.objects.filter(site_cate = cate_detail_obj)

    site_cates = SiteCate.objects.all()

    return render(request, 'index.html', {
        'all_articles': all_articles,
        'site_cates': site_cates,

    })


class RegisterView(View):

    def get(self, request):
        register_form = RegisterForm()
        return render(request, 'register.html', {
            'register_form': register_form,
        })

    def post(self, request):
        print(request.POST)
        register_form = RegisterForm(request.POST)
        if register_form.is_valid():
            return HttpResponse(json.dumps({'status':'success'}),
                                content_type='application/json')

        else:
            form_errors = register_form.errors
            return HttpResponse(json.dumps({'status': 'fail', 'form_errors': register_form.errors}),
                                content_type= 'application/json')
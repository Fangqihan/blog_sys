from django.shortcuts import render, HttpResponse
from blog_sys import settings
from my_blog.models import Article


def login(request):

    return render(request, 'login.html')



def get_valid_img(request):

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
    from PIL import Image, ImageDraw, ImageFont
    from random import randint
    from io import BytesIO
    from string import ascii_letters, digits
    import random

    def generate_code():
        """生成六位数随机验证码"""
        code = "".join(random.sample(ascii_letters + digits, 6))
        return code
    code = generate_code()

    # 1. 生成图片
    # 颜色随机
    img = Image.new(mode="RGB", size=(213, 35), color=(randint(0, 255), randint(0, 255), randint(0, 255)))

    draw = ImageDraw.Draw(img, mode='RGB')   # 生成绘板对象
    # 2. 向图片写入内容
    font = ImageFont.truetype("static/fonts/kumo.ttf", 30)  # 字体样式必须引入, 字体大小
    # 保证每次生成不同的问题,且位数保证6位

    draw.text([60, 0], code, color=(randint(0, 255), randint(0, 255), randint(0, 255)), font=font)  # 参数,:坐标, 文字, 颜色, 字体样式

    # 3. 保存到内存
    f = BytesIO()
    img.save(f, 'png')

    # 4. 读取图片
    data = f.getvalue()


    #  方式5, 验证码更新,必须是局部刷新,点击刷新


    return HttpResponse(data)


def index(request):
    type_choices = Article.type_choices

    all_articles = Article.objects.all()

    return render(request, 'index.html', {
        'type_choices': type_choices,
        'all_articles': all_articles,

    })
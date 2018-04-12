from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
import json
from datetime import datetime

from django.shortcuts import render, HttpResponse, redirect
from django.contrib import auth
from django.contrib.auth.hashers import make_password

from my_blog.models import *
from .utils import generate_code, get_random_color
from .forms import RegisterForm
from django.contrib.auth.backends import ModelBackend


def my_login(request):
    if request.method == "POST":
        # 1,从session中获取本次请求生成的图片代码
        code = request.session.get("valid_code", '').upper()
        path = request.POST.get('path', '')
        # 2. 获取用户提交的数据
        username = request.POST.get('username',"")
        pwd = request.POST.get('password',"")
        valid_code = request.POST.get('valid_code',"")
        # 3. 判断验证码是否合格
        if valid_code.upper() != code:
            return HttpResponse(json.dumps({'status': "fail", 'msg': '验证码有误', 'user':None}),
                                content_type="application/json")
        # 4. 根据用户名和密码从数据库查询匹配的用户
        user = auth.authenticate(username=username, password=pwd)
        if user:
            # 5. 找到用户,则创建或修改session信息, 修改为登录状态
            auth.login(request, user)
            username = user.username

            return HttpResponse(json.dumps({'status': "success", 'msg': '', 'user':username, 'path':path}),
                                content_type="application/json")
        else:
            return HttpResponse(json.dumps({'status': "fail", 'msg': '用户名或密码错误', 'user': None}),
                                content_type="application/json")

    elif request.method == "GET":
        path = request.GET.get('path', '')
        if not path:
            path = '/index/'
        print('path', path)
        return render(request, 'login.html', {
            'path': path
        })


def my_logout(request):
    auth.logout(request)
    return redirect('/login/')


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

#
# class RegisterView(View):
#     def get(self, request):
#         register_form = RegisterForm()
#         return render(request, 'register.html', {
#             'register_form': register_form,
#         })
#
#     # 常规方法
#     def post(self, request):
#         register_form = RegisterForm(request.POST)
#
#         if register_form.is_valid():
#             flag = True  # 判断是否有错误发生
#             error_msg = {'username': '', 'password': '',  'email': '', 'valid_code': ''}
#             # 1. 获取所有的注册信息
#             code = request.session.get("valid_code", '').upper()
#             valid_code = register_form.cleaned_data.get('valid_code', '').upper()
#
#             # 2. 验证图片验证码是否合格
#             if code != valid_code:
#                 flag = False
#                 error_msg['valid_code'] = '验证码有误!'
#
#             # 3. 验证密码是否一致
#             pwd1 = register_form.cleaned_data.get('password1', '')
#             pwd2 = register_form.cleaned_data.get('password2', '')
#             if pwd1 != pwd2:
#                 flag = False
#                 error_msg['password'] = '密码输入不一致!'
#
#             # 4. 验证email唯一性
#             email = register_form.cleaned_data.get('email', '')
#             user = UserInfo.objects.filter(email=email)
#             if user:
#                 flag = False
#                 error_msg['email'] = '邮箱已注册!'
#
#             if flag:
#                 # 若没有错误信息产生
#                 # 开始注册
#                 user = UserInfo()
#                 user.username = register_form.cleaned_data.get('username', '')
#                 user.email = email
#                 user.password = make_password(password=pwd1)
#                 user.save()
#                 return HttpResponse(json.dumps({'status': 'success'}),
#                                     content_type='application/json')
#
#             else:
#                 # 返回错误信息
#                 return HttpResponse(json.dumps({'status': 'logic_fail', 'error_msg': error_msg}),
#                                     content_type='application/json')
#
#         else:
#             return HttpResponse(json.dumps({'status': 'form_fail', 'form_errors': register_form.errors}),
#                                 content_type='application/json')

            # def post(self, request):
            #     """利用钩子,自定义is_valid方法"""
            #     register_form = RegisterForm(request.POST)
            #     if register_form.is_valid():
            #
            #     else:
            #         return HttpResponse(json.dumps({'status': 'fail', 'form_errors': register_form.errors}),
            # #                             content_type='application/json')

def register(request):
    if request.method == "GET":
        register_form = RegisterForm(request)
        return render(request, 'register.html', {
            'register_form': register_form,
        })

    elif request.method == 'POST':
        register_form = RegisterForm(request, request.POST)
        if register_form.is_valid():
            username = register_form.cleaned_data.get('username', '')
            password = register_form.cleaned_data.get('password1', '')
            email = register_form.cleaned_data.get('email', '')
            file = request.FILES.get('file_choose')
            UserInfo.objects.create_user(username=username, password=password, email=email, avatar=file)
            return HttpResponse(json.dumps({'status':'success'}), content_type='application/json')

        else:
            # 返回表单验证错误的信息
            return HttpResponse(json.dumps({'status':'fail', 'form_error': register_form.errors}),
                                content_type='application/json')

    '''
    # 没有涉及到全局钩子的使用
    elif request.method == "POST":
        register_form = RegisterForm(request.POST)

        if register_form.is_valid():
            flag = True  # 判断是否有错误发生
            error_msg = {'username': '', 'password2': '',  'email': '', 'valid_code': '', 'file': ''}
            # 1. 验证图片验证码是否合格
            code = request.session.get("valid_code", '').upper()
            valid_code = register_form.cleaned_data.get('valid_code', '').upper()
            if code != valid_code:
                flag = False
                error_msg['valid_code'] = '验证码有误!'

            # 2. 验证密码是否一致
            pwd1 = register_form.cleaned_data.get('password1', '')
            pwd2 = register_form.cleaned_data.get('password2', '')
            if pwd1 != pwd2:
                flag = False
                error_msg['password2'] = '密码输入不一致!'

            # 3. 验证email唯一性
            email = register_form.cleaned_data.get('email', '')
            user = UserInfo.objects.filter(email=email)
            if user:
                flag = False
                error_msg['email'] = '邮箱已注册!'

            # 4. 验证上传文件是否存在
            file = request.FILES.get('file', '')
            print(file)
            if not file:
                flag = False
                error_msg['file'] = '请上传图片!'

            if flag:
                # 若没有错误信息产生
                # 开始注册
                user = UserInfo()
                user.username = register_form.cleaned_data.get('username', '')
                user.email = email
                user.password = make_password(password=pwd1)
                user.avatar = file
                user.save()
                return HttpResponse(json.dumps({'status': 'success'}),
                                    content_type='application/json')

            else:
                # 返回错误信息
                return HttpResponse(json.dumps({'status': 'logic_fail', 'error_msg': error_msg}),
                                    content_type='application/json')

        else:
            return HttpResponse(json.dumps({
                'status': 'form_fail', 'form_errors': register_form.errors
            }), content_type='application/json')
    
    '''


def reset_pwd(request):
    user = UserInfo.objects.get(username='kate')
    user.password = make_password('abc123')
    user.save()
    return HttpResponse("密码重置成功!")


def form_data_test(request):
    if request.method == "POST":
        file = request.FILES.get('file')
        with open(file.name, 'wb') as f:
            for i in file.chunks():
                f.write(i)
        return HttpResponse('OK')

    else:
        return render(request, 'form_test.html')


def user_page(request, site):
    '''用户主页面, 即用户文章列表页'''
    if request.method == 'GET':
        # 1. 判断用户输入的site是否存在, 存在则跳转用户主页,否则返回404页面
        blog = Blog.objects.filter(site=site)
        if blog:
            blog = blog.first()
            all_articles = Article.objects.filter(blog=blog)

            # 2. 判断是否有cate参数, 若存在按照类别筛序文章页面
            cate_name = request.GET.get('cate')
            cate_titles = Category.objects.filter(title=cate_name)

            # 3. 判断是否有tag参数, 若有则按照标签筛序所有文章
            tag_name = request.GET.get('tag')
            tag_titles = Tag.objects.filter(title=tag_name)
            if cate_titles:
                # 按照类型筛选文章
                cate_title = cate_titles[0]
                all_articles = all_articles.filter(category=cate_title)

            elif tag_titles:
                # 按照标签筛选文章
                tag_title = tag_titles[0]
                all_articles = all_articles.filter(tags=tag_title)

            # 获取博客年龄
            blog_age = datetime.now() - blog.user.date_joined
            # 获取粉丝数
            fans_list = UserFans.objects.filter(user_id=blog.user)
            # 获取关注的用户数量
            fans_for_list = UserFans.objects.filter(follower_id=blog.user)
            # 获取当前blog所有文章的标签
            tag_list = Tag.objects.filter(blog=blog)
            # 获取当前blog所有文章分类
            cate_list = Category.objects.filter(blog_id=blog.nid)

            return render(request, 'user_homepage.html',{
                'blog': blog,
                'all_articles': all_articles,
                'blog_age': blog_age,
                'fans_list': fans_list,
                'fans_for_list': fans_for_list,
                'tag_list': tag_list,
                'cate_list': cate_list,
                'request': request,

            })

        else:
            return HttpResponse('对不起,资源不存在')

# def user_filter_page(request, site, filter, filer_name):
#     print(filer_name)
#     """1. 判断过滤类类型; 2. 根据具体的类型筛选文章"""
#     article_list = None
#
#     # 根据第一个参数网址确定当前的blog
#     # http://localhost:8800/bob/cate/html%E5%9F%BA%E7%A1%80/
#     # http://localhost:8800/bob/cate/%E8%8B%B1%E8%AF%AD/
#
#     blog = Blog.objects.filter(site=site)
#     print(blog)
#     if blog:
#         blog = blog.first()
#         if filter == 'tag':
#
#             pass
#
#         elif filter == 'cate':
#             article_list = blog.article_set.all()
#             print(article_list)
#             article_list = article_list.objects.filter(category=filer_name)
#             print('cate筛选========', article_list)
#
#     return render(request, 'user_articles_filter.html', {
#         'article_list': article_list,
#     })


def fans_for(request):
    """加关注点击触发事件"""
    if request.method == "POST":
        user_id = int(request.POST.get('user_id', ''))
        follower_id = int(request.POST.get('follower_id', ''))
        user_fan_obj = UserFans.objects.filter(user_id=user_id, follower_id=follower_id)
        msg = ''
        if user_fan_obj:
            # 若数据库存在已存在,说明来两者已绑定粉丝用户关系,则取消关注
            user_fan_obj.delete()
            msg = '+加关注'
        else:
            UserFans.objects.create(user_id=user_id, follower_id=follower_id)
            msg = '取消关注'

        return HttpResponse(json.dumps({'status': "success", 'msg': msg}),
                        content_type="application/json")


def article_detail(request, article_id):
    if request.method == 'GET':
        articles = Article.objects.filter(nid=int(article_id))
        if articles:
            # 存在对应的文章
            article = articles[0]
            comment_list = article.comment_set.all()
            return render(request, 'article_detail.html', {
                'article': article,
                'comment_list': comment_list,
            })

        else:
            return HttpResponse('文章不存在')


def article_detail_2(request, article_id):
    """对于多级评论数,第一次请求之返回文章内容,
        然后待加载完毕后,再触发onload事件,利用ajax再次发送请求,并加载所有的评论"""
    articles = Article.objects.filter(nid=int(article_id))

    if articles:
        # 取出文章对象
        article = articles[0]

        # 取出此文章的所有评论,并且只取某些字段
        comment_list = article.comment_set.all().values('nid', 'content', 'parent_id_id')
        print('comment_list', comment_list)
        # 判断本次请求是否是ajax发送的
        if request.is_ajax():
            for d in comment_list:
                d['children_contents'] = []

            # 对其结果进行处理,整合成特殊结构
            comment_dict = {}

            for d in comment_list:
                id = d.get('nid')
                comment_dict[id] = d

            for k in comment_dict:
                pid = comment_dict[k]['parent_id_id']
                if pid:
                    comment_dict[pid]['children_contents'].append(comment_dict[k])

            # 整理出嵌套有自评论的根评论
            res = []
            for i in comment_dict:
                if not comment_dict[i]['parent_id_id']:
                    res.append(comment_dict[i])

            return HttpResponse(json.dumps(res))

        else:
            return render(request, 'article_detail_2.html', {
                'article': article,
            })
    else:
        return HttpResponse('文章不存在')


def user_favor(request):
    user_nid = request.user.nid
    article_id = request.POST.get('article_id', '')
    article = Article.objects.get(nid=int(article_id))
    # 添加点赞记录
    Poll.objects.create(article_id=article_id, user_id=user_nid)

    # 自加文章的点赞数
    article.poll_num += 1
    article.save()
    return HttpResponse(json.dumps({'status':'success', 'poll_num':article.poll_num}), content_type='application/json')


def user_comment(request):
    """方法1, 直接在前端操作评论内容"""
    user_id = request.user.nid
    article_id = request.POST.get("article_id")
    comment_content = request.POST.get("comment_content").strip()
    # 若评论内容为空,则不添加任何信息
    if not comment_content:
        return HttpResponse('noy ok')

    # 1. 查看是否是通过回复(有父评论)发送还是直接评论发送
    if request.POST.get("parent_comment_id"):
        # 2. 获取该评论的父级评论id并保存记录
        c = int(request.POST.get("parent_comment_id"))
        comment_obj = Comment.objects.create(article_id=article_id, content=comment_content, user_id=user_id,
                                             parent_id_id=c)
    else:
        comment_obj = Comment.objects.create(article_id=article_id, content=comment_content, user_id=user_id)

    from django.db.models import F
    # 3. 对评论数量自加操作
    Article.objects.filter(nid=article_id).update(comment_num=F("comment_num") + 1)

    # 只传输创建时间过去
    response_ajax = {"comment_createTime": str(comment_obj.create_time)[:16], }  # 很关键,不去毫秒!
    return HttpResponse(json.dumps(response_ajax), content_type='application/json')


def user_comment_method1(request):
    '''方法2:从后端将新增内容传入,在评论回复遇到问题,暂时无法解决,所以先采用方法1,在前端操作评论
    对文章增加用户评论'''
    article_id = request.POST.get('article_id', '')
    # print('article_id', article_id)
    comment_content = request.POST.get('comment_content', '').strip()
    # print('comment_content', len(comment_content))
    user_id = request.user.nid
    # print('user_id', user_id)


    if not comment_content:
        return HttpResponse(json.dumps({'status': 'fail', 'msg': '内容不能为空', 'comment':''}),
                            content_type='application/json')

    comment = Comment()
    comment.user_id = user_id
    comment.content = comment_content
    comment.article_id = article_id
    comment.save()

    # 生成新增的评论标签, 通过json序列化传送到前端的ajax
    msg = """<div class="comment_item">
                    <div class="comment_subtitle">
                        <span>{create_time}</span>&nbsp;&nbsp;
                        <a href="/blog/{username}"><span>{nickname}</span></a>
                    </div>
                    <div class="comment_content"><span>{response}</span></br>{content}</div>
                    <div class="comment_response">
                        <span class="glyphicon glyphicon-thumbs-up comment_favor">
                            支持(<span class="comment_poll_num">{comment_poll_num}</span>)
                        </span>

                        <input hidden id="comment_id" value="{comment_id}">
                        &nbsp;&nbsp;
                        <span class="glyphicon glyphicon-comment" id="comment_response">回复</span>
                    </div>
                </div>""".format(create_time=comment.create_time, nickname=comment.user.nickname,
                                content=comment.content, username=request.user.username,
                                 poll_num=comment.poll_num, comment_id=comment.nid, comment_poll_num=comment.poll_num,
                                 response='')

    # 修改当前文章的评论数
    article = Article.objects.get(nid=int(article_id))
    article.comment_num += 1
    article.save()
    return HttpResponse(json.dumps({'status': 'success', 'msg': msg}), content_type='application/json')


def comment_favor(request):
    '''对用户评论点赞'''
    user_id = request.user.nid
    comment_id = request.POST.get('comment_id', '')
    comment = Comment.objects.get(nid=int(comment_id))

    # 查看是否有重复的评论者
    comments = Comment_poll.objects.filter(poll_user_id=user_id, comment_id=comment_id)
    if not comments:
        Comment_poll.objects.create(poll_user_id=user_id, comment_id=comment_id)

        # 增加评论的点赞数
        comment.poll_num += 1
        comment.save()
        # 渲染评论点赞的数量
        return HttpResponse(json.dumps({'status':'success', 'comment_id': str(comment.nid),
                                        'poll_num':comment.poll_num}), content_type='application/json')

    # 重复点赞评论
    return HttpResponse(json.dumps({'status': 'fail', 'msg': '对不起, 您已经支持过!','comment_id': str(comment.nid)}),
                        content_type='application/json')


def article_detail_page(request, pk):
    article = Article.objects.filter(nid=int(pk)).first()
    if not article:
        return HttpResponse('<h1>资源页面不存在</h1>')

    return render(request, 'article_detail_2.html', {
        'pk': pk,
        'article': article,
    })
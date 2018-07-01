# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com

from django import template
from my_blog.models import *

register = template.Library()   #register的名字是固定的,不可改变


@register.filter
def cate_count(cate):
    # print(cate)
    count = 0
    # print('===========', cate)
    # 从所有文章中根据cate进行筛选
    article_list = Article.objects.filter(category=cate)
    # print('过滤器结果=====', article_list)
    if article_list:
        count = article_list.all().count()
    return count


@register.filter
def tag_count(tag):
    # print(tag)
    count = 0
    # 找出当前标签对应的blog的所有文章
    article_list = tag.blog.article_set.all().filter(tags=tag)
    # print('==========', article_list)
    # 通过TagToArticle表中通过tag反向查询到所有的article对象
    # print('过滤器结果=====', article_list)
    if article_list:
        count = article_list.count()
    return count


from my_blog.models import Article
from django.shortcuts import HttpResponse
from ..utils import transform_list


def process_menu_data(pk):
    article = Article.objects.filter(nid=int(pk)).first()
    if not article:
        return HttpResponse("<h1>资源不存在!</h1>")
    comment_list = list(article.comment_set.all().values('nid', 'content', 'user__username', 'parent_id_id', 'create_time'))
    comment_list = transform_list(comment_list)
    return comment_list


def produce_html(comment_list):
    html = ''
    tpl1 = """        
         <div class="comment_item">
           <div class="comment-header">
               <a href="#"><span class="user_name">{0}</span></a>
                <span class="comment_time">{1}</span>
                <span class="comment_content">{2}</span>
                <span id="{3}" hidden></span>
                <a class="reply">回复</a>
            </div>
           <div class="comment-body">{4}</div>
        </div>
           """
    for item in comment_list:
        if item['children_contents']:
            html += tpl1.format(item['user__username'], str(item['create_time'])[:19], item['content'].strip(), item['nid'],
                                produce_html(item["children_contents"]))
        else:
            html += tpl1.format(item['user__username'], str(item['create_time'])[:19], item['content'].strip(),  item['nid'], '')

    return html


from django.utils import safestring



# 引入菜单标签到模板中
@register.simple_tag
def user_comment(pk):
    # 1. 判断用户是否登录,即查看有没有权限列表
    # 2. 若为登录用户,则调动自定义函数从数据库取到菜单相关的数据
    data = process_menu_data(pk)
    # 3. 生成html, 注意转换成可以渲染的html
    html = safestring.mark_safe(produce_html(data))
    return html



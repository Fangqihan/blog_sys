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






from django.db import models
from django.contrib.auth.models import AbstractUser


class UserInfo(AbstractUser):
    """
    用户信息
    """
    nid = models.BigAutoField(primary_key=True)
    nickname = models.CharField(max_length=50, verbose_name='昵称', null=True, blank=True)
    telephone = models.CharField(max_length=11, blank=True, null=True, unique=True, verbose_name='手机号码')
    avatar = models.FileField(verbose_name='头像',upload_to = 'user/%Y/%m')

    def __str__(self):
        return self.username

    class Meta:
        verbose_name = '用户信息'
        verbose_name_plural = verbose_name


class Blog(models.Model):
    """
    博客信息
    """
    nid = models.BigAutoField(primary_key=True)
    title = models.CharField(verbose_name='个人博客标题', max_length=64)
    site = models.CharField(verbose_name='个人博客前缀', max_length=32, unique=True)
    theme = models.CharField(verbose_name='博客主题', max_length=32)
    user = models.OneToOneField(to='UserInfo', to_field='nid')

    class Meta:
        verbose_name = '博客'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


class SiteCate(models.Model):
    title = models.CharField(max_length=32, verbose_name='网站分类')

    class Meta:
        verbose_name = '网站分类'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


class SiteCateDetail(models.Model):
    title = models.CharField(max_length=32, verbose_name='网站详细分类')
    parent = models.ForeignKey(SiteCate)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = '网站分类详情'
        verbose_name_plural = verbose_name


class Category(models.Model):
    """
    博主个人文章分类表
    """
    nid = models.AutoField(primary_key=True)
    title = models.CharField(verbose_name='分类标题', max_length=32)
    blog = models.ForeignKey(verbose_name='所属博客', to='Blog', to_field='nid')

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = '自定义分类'
        verbose_name_plural = verbose_name
        ordering = ['title']


class Article(models.Model):
    nid = models.BigAutoField(primary_key=True)
    title = models.CharField(max_length=50, verbose_name='文章标题')
    desc = models.CharField(max_length=255, verbose_name='文章描述')
    comment_num= models.IntegerField(default=0)
    poll_num= models.IntegerField(default=0)
    category = models.ForeignKey(verbose_name='自定义文章类型', to='Category', to_field='nid', null=True)
    read_num = models.IntegerField(verbose_name='阅读数', default=0)
    create_time = models.DateTimeField(verbose_name='创建时间', auto_now_add=True)
    blog = models.ForeignKey(verbose_name='所属博客', to='Blog', to_field='nid')
    site_cate = models.ForeignKey(SiteCateDetail, verbose_name='网站分类', null=True, blank=True)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = '文章'
        verbose_name_plural = verbose_name


class ArticleDetail(models.Model):
    """文章详细表"""
    content = models.TextField(verbose_name='文章内容', )
    article = models.OneToOneField(verbose_name='所属文章', to='Article', to_field='nid')

    class Meta:
        verbose_name = '文章详情'
        verbose_name_plural = verbose_name


class Comment(models.Model):
    """
    评论表
    """
    nid = models.BigAutoField(primary_key=True)
    article = models.ForeignKey(verbose_name='评论文章', to='Article', to_field='nid')
    content = models.CharField(verbose_name='评论内容', max_length=255)
    create_time = models.DateTimeField(verbose_name='创建时间', auto_now_add=True)
    parent_id = models.ForeignKey('self', blank=True, null=True, verbose_name='父级评论')
    user = models.ForeignKey(verbose_name='评论者', to='UserInfo', to_field='nid')
    poll_num = models.IntegerField(default=0)

    def __str__(self):
        return self.content

    class Meta:
        verbose_name = '评论'
        verbose_name_plural = verbose_name


class Poll(models.Model):
    """
    点赞表
    """
    user = models.ForeignKey('UserInfo', null=True)
    article = models.ForeignKey("Article", null=True)
    comment = models.ForeignKey("Comment", null=True)

    class Meta:
        verbose_name = '点赞'
        verbose_name_plural = verbose_name




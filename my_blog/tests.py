
# # 1. 模拟取出某文章的所有评论的部分信息如下,
# comment_list = [
#     {'id': 1, 'content': '...', 'Pid': None, 'children_contents': []},
#     {'id': 2, 'content': '...', 'Pid': None, 'children_contents': []},
#     {'id': 3, 'content': '...', 'Pid': 1, 'children_contents': []},
#     {'id': 4, 'content': '...', 'Pid': 1, 'children_contents': []},
#     {'id': 5, 'content': '...', 'Pid': 4, 'children_contents': []},
#     {'id': 6, 'content': '...', 'Pid': 3, 'children_contents': []},
#     {'id': 7, 'content': '...', 'Pid': 6, 'children_contents': []},
#     {'id': 8, 'content': '...', 'Pid': None, 'children_contents': []},
# ]
#
# # 2. 将子评论的内容放在父评论的children_contents类表中
#
# # for i in comment_list:
# #     if comment_list[i]['Pid']:
# #         # 此时,又一次for循环找出id与本次的pid相等的项,但是这样实现起来效率会很低,两次for循环,所以不采用,想改进的办法
# #         ...
#
# # 3, 新建数据结构{1: {'id':1, ...}, 2: {'id':2, ...},}
#
# # from collections import OrderedDict
# #
# # comment_dict = OrderedDict()
#
# comment_dict = {}
#
# for d in comment_list:
#     id = d.get('id')
#     comment_dict[id] = d
#
# '''
# # 新的数据结构
# 1 {'id': 1, 'content': '...', 'Pid': None, 'children_contents': []}
# 2 {'id': 2, 'content': '...', 'Pid': None, 'children_contents': []}
# 3 {'id': 3, 'content': '...', 'Pid': 1, 'children_contents': []}
# 4 {'id': 4, 'content': '...', 'Pid': 1, 'children_contents': []}
# 5 {'id': 5, 'content': '...', 'Pid': 4, 'children_contents': []}
# 6 {'id': 6, 'content': '...', 'Pid': 3, 'children_contents': []}
# 7 {'id': 7, 'content': '...', 'Pid': 6, 'children_contents': []}
# 8 {'id': 8, 'content': '...', 'Pid': None, 'children_contents': []}
# '''
#
# for k in comment_dict:
#     pid = comment_dict[k]['Pid']
#     if pid:
#         comment_dict[pid]['children_contents'].append(comment_dict[k])
#
# # 4. 删除所有的子评论
# res = {}
# for i in comment_dict:
#     if not comment_dict[i]['Pid']:
#         res[i] = comment_dict[i]
#
#
# # 5. 结构就是所有根评论的包含其所有子评论了!


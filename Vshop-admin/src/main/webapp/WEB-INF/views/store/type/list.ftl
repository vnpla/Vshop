<@layout.head>
<script type="text/javascript" src="${base}/res/js/jquery-ui/jquery.ui.js"></script>
<script type="text/javascript" src="${base}/res/js/jquery-ui/i18n/zh-CN.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="${base}/res/js/jquery-ui/themes/ui-lightness/jquery.ui.css"  />
<script type="text/javascript" src="${base}/res/js/jquery.edit.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/store/jquery.store_type.js" charset="utf-8"></script>
<script type="text/javascript">
    function deleteClass(){
        var items = $("input[name='ids']:checked").length;
        if (items==0) {
            alert("请至少选择一个要删除的项目");
        }else{
            if(confirm('您确定要删除吗?')){
                $('#form_list').submit();
            }
        }
    }
    function delRow(obj){
        if(confirm('您确定要删除吗?')) {
            $(obj).parents("tr").find("td:eq(0)>input").attr("checked", true);
            $('#form_list').submit();
        }
    }
    
    function delClassid(classid) {
		//校验菜单底线是否含有子菜单
		valicountparent(classid);
		if (vadate) {
			if (confirm('您确定要删除吗?')) {
				var url = "${base}/store/type/deleteid";
				var para = {
					"classid" : classid
				};
				$.ajax({
					type : "post",
					url : url,
					data : para,
					dataType : "json",
					async : false,
					success : function(data) {
						if (data.success == "true") {
							alert(data.result);
							window.location = '${base}/store/type/list';
						} else {
							alert(data.result);
						}
					}
				});
			}
		} else {
			alert("请删除子菜单后再进行删除！");
		}
	}
    
    var vadate = false;
    function valicountparent(classid) {
		var url = "${base}/store/type/validateparentid";
		var para = {
			"id" : classid
		};
		var va = $.ajax({
			type : "post",
			url : url,
			data : para,
			dataType : "json",
			async : false,
			success : function(data) {
				if (data) {
					vadate = true;
					return true;
				} else {
					vadate = false;
					return false;
				}
			}
		});
	}
</script>
</@layout.head>
<@layout.body>
<div class="page">
    <div class="fixed-bar">
        <div class="item-title">
            <h3>商家分类</h3>
            <ul class="tab-base">
                <li><a href="JavaScript:void(0);" class="current"><span>管理</span></a></li>
                <li><a href="${base}/store/type/addIndex?id=0" ><span>新增</span></a></li>
            </ul>
        </div>
    </div>
    <div class="fixed-empty"></div>
    <table class="table tb-type2" id="prompt">
        <tbody>
        <tr class="space odd">
            <th colspan="12" class="nobg"><div class="title">
                <h5>操作提示</h5>
                <span class="arrow"></span></div></th>
        </tr>
        <tr>
            <td><ul>
                <li>在会员开通商家时，可指定渠道分类</li>
                <li>在商家列表页，可以通过选择商家分类查询商家列表,点击分类名前“+”符号，显示当前分类的下级分类</li>
            </ul></td>
        </tr>
        </tbody>
    </table>
    <form id="form_list" method='post' action="${base}/store/type/delete">
        <table class="table tb-type2 nobdb">
            <thead>
            <tr class="thead">
                <th><input type="checkbox" class="checkall" id="checkall_1"></th>
                <th>排序</th>
                <th>分类名称</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <#list list as c>
                <tr class="hover edit">
                    <td class="w36"><input type="checkbox" name='ids' value="${c.id}" class="checkitem">
                        <#if c.hasChild == 0>
                            <img fieldid="${c.id}" status="close" nc_type="flexType"  src="${base}/res/images/tv-item.gif">
                        <#else>
                            <img fieldid="${c.id}" status="open" nc_type="flexType" level="1" src="${base}/res/images/tv-expandable.gif">
                        </#if>
                    </td>
                    <td class="w48 sort"><span title="可编辑" datatype="number" modUrl="${base}/store/type/modifySort"
                                               fieldid="${c.id}" fieldname="sort" nc_type="inline_edit" class="editable">${c.sort}</span></td>
                    <td class="name">
                        <span title="分类名称" required="1" fieldid="${c.id}"  modUrl="${base}/store/type/modifyName"
                              fieldname="name" nc_type="inline_edit" class="node_name editable">${c.name}</span>
                        <a class='btn-add-nofloat marginleft' href="${base}/store/type/addIndex?id=${c.id}&parentId=${c.id}">新增下级</a>
                    </td>
                    <td class="w84"><span><a href="${base}/store/type/updateIndex?id=${c.id}">编辑</a> | <a href="JavaScript:void(0);"onclick="delClassid('${c.id}')">删除</a> </span></td>
                </tr>
            </#list>
            </tbody>
            <tfoot>
            <tr id="batchAction" >
                <td><input type="checkbox" class="checkall" id="checkallBottom"></td>
                <td colspan="16" id="dataFuncs"><label for="checkallBottom">全选</label>
                    &nbsp;&nbsp;<a href="JavaScript:void(0);" class="btn" onclick="deleteClass()"><span>删除</span></a></td>
            </tr>
            </tfoot>
        </table>
    </form>
</div>
</@layout.body>
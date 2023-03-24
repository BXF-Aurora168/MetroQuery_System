<%@ page import="java.util.ArrayList" %>
<%@ page import="com.SubwayBean" %>
<%@ page language= "java" contentType= "text/html; charset=UTF-8"
         pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
  <title>石家庄铁道大学北京地铁查询系统</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="css/mysub_style.css">
  <script type="text/jscript">
        //图片定时转换
        var curIndex=0;
        var timeInterval=2000;
        var arr=new Array();
        arr[0]="./images/p_14.jpg";
        arr[1]="./images/p__15.jpg";
        arr[2]="./images/p_16.jpg";
        setInterval("changeImg()",timeInterval);
        function changeImg(){
        	var obj=document.getElementById("obj");
        	if(curIndex==arr.length-1){
        		curIndex=0;
        	}else{
        		curIndex+=1;
        	}
        	obj.src=arr[curIndex];
        }

        //显示当前时间
        function showLocale(objD) {
        	var str, colorhead, colorfoot;
        	var yy = objD.getYear();
        	if (yy < 1900)
        		yy = yy + 1900;
        	var MM = objD.getMonth() + 1;
        	if (MM < 10)
        		MM = '0' + MM;
        	var dd = objD.getDate();
        	if (dd < 10)
        		dd = '0' + dd;
        	var hh = objD.getHours();
        	if (hh < 10)
        		hh = '0' + hh;
        	var mm = objD.getMinutes();
        	if (mm < 10)
        		mm = '0' + mm;
        	var ss = objD.getSeconds();
        	if (ss < 10)
        		ss = '0' + ss;
        	var ww = objD.getDay();
        	colorhead = "<font color=\"#000000\">";
        	if (ww == 0)
        		ww = "星期日";
        	if (ww == 1)
        		ww = "星期一";
        	if (ww == 2)
        		ww = "星期二";
        	if (ww == 3)
        		ww = "星期三";
        	if (ww == 4)
        		ww = "星期四";
        	if (ww == 5)
        		ww = "星期五";
        	if (ww == 6)
        		ww = "星期六";
        	colorfoot = "</font>"
        	str = colorhead + yy + "-" + MM + "-" + dd + " " + hh + ":" + mm
        			+ ":" + ss + "  " + ww + colorfoot;
        	return (str);
        }

        function tick() {
        	var today;
        	today = new Date();
        	document.getElementById("localtime").innerHTML = showLocale(today);
        	window.setTimeout("tick()", 1000);
        }
        window.onload = function() {
        	tick();
        }
        //显示tab（tabHeadId：tab头中当前的超链接；tabContentId要显示的层ID）
        function showTab(tabHeadId,tabContentId)
        {
            //tab层
            var tabDiv = document.getElementById("tabDiv");
            //将tab层中所有的内容层设为不可见
            //遍历tab层下的所有子节点
           // var taContents = tabDiv.childNodes;
          //  for(i=0; i<taContents.length; i++)
           // {
                //将所有内容层都设为不可见
            //    if(taContents[i].id!=null && taContents[i].id != 'tabsHead')
             //   {
              //      taContents[i].style.display = 'none';
              //  }
            //}
           document.getElementById('tabContent1').style.display='none';
            document.getElementById('tabContent2').style.display='none';
            document.getElementById('tabContent3').style.display='none';
            document.getElementById('tabContent4').style.display='none'
            //将要显示的层设为可见
            document.getElementById(tabContentId).style.display = 'block';
            //遍历tab头中所有的超链接
            var tabHeads = document.getElementById('tabsHead').getElementsByTagName('a');
            for(i=0; i<tabHeads.length; i++)
            {
                //将超链接的样式设为未选的tab头样式
                tabHeads[i].className='tabs';
            }
            //将当前超链接的样式设为已选tab头样式
            document.getElementById(tabHeadId).className='curtab';
            document.getElementById(tabHeadId).blur();
        }

</script>
</head>

<body>

<div style="width: 100%; font-family: 微软雅黑; text-align: center; font-size: 20pt; ">石家庄铁道大学北京地铁查询系统</div><br/>
<div id="localtime" style="text-align: center;"></div>
<div id="tabDiv" style="width: 1400px">

  <div id="tabsHead">
    <a id="tabs1" class="curtab" href="javascript:showTab('tabs1','tabContent1')">线路规划查询结果</a>

  </div>

  <div id="tabContent1" style="display:block ">
    <form action="lineresult.jsp">
      <table style="border-width: 0; width: 100%; padding: 5px; ">
        <tr>

          <table border="1" cellpadding="10" style=" border-left-color: #B0C4DE; border-bottom-color: #B0C4DE; width: 100%;border-top-style: solid; border-top-color: #B0C4DE; border-right-style: solid; border-left-style: solid; height: 250px; border-right-color: #B0C4DE; border-bottom-style: solid">
            <h4 align="center">我们为您列出了所有可能的路线，第一条为最优路线，请您视情况选择最佳路线</h4>
            <tr>
              <th align="center" bgcolor="#F0FFFF" ><%="起始站"%></th>
              <th align="center" bgcolor="#F0FFFF" ><%="终点站"%></th>
              <th align="center" bgcolor="#F0FFFF" ><%="经过站数"%></th>
              <th align="center" bgcolor="#F0FFFF" ><%="具体路线"%></th>
            </tr>
                <%
                response.setContentType("text/html;charset=UTF-8");

                ArrayList<SubwayBean> arr = (ArrayList<SubwayBean>) request.getAttribute("routeMain");

                  SubwayBean subwayBean1 = new SubwayBean();
                  subwayBean1._StartStation = arr.get(0)._StartStation;
                  subwayBean1._EndStation   = arr.get(0)._EndStation;
                  subwayBean1._Number       = arr.get(0)._Number;
                  subwayBean1._Path         = arr.get(0)._Path;
                %>

            <tr>
              <td align="center" bgcolor="#f5f5dc"><%=subwayBean1._StartStation%></td>

              <td align="center" bgcolor="#f5f5dc"><%=subwayBean1._EndStation%></td>

              <td align="center" bgcolor="#f5f5dc"><%=subwayBean1._Number%></td>

              <td align="center" bgcolor="#f5f5dc"><%=subwayBean1._Path%></td>

            </tr>
                <%
                for (int i = 1; i < arr.size(); i++) {

                  SubwayBean subwayBean = new SubwayBean();
                  subwayBean._StartStation = arr.get(i)._StartStation;
                  subwayBean._EndStation   = arr.get(i)._EndStation;
                  subwayBean._Number       = arr.get(i)._Number;
                  subwayBean._Path         = arr.get(i)._Path;
                %>

            <tr>
              <td align="center" bgcolor="#F5F5F5"><%=subwayBean._StartStation%></td>

              <td align="center" bgcolor="#F5F5F5"><%=subwayBean._EndStation%></td>

              <td align="center" bgcolor="#F5F5F5"><%=subwayBean._Number%></td>

              <td align="center" bgcolor="#F5F5F5"><%=subwayBean._Path%></td>

            </tr>


                <%
                }
                %>

              </td>
            </tr>

          </table>
          </td>
        </tr>
        <tr>
        </tr>
        <tr>
        </tr>
      </table>
    </form>
  </div>
</div>
<hr />
<div style="text-align: center; width: 100%; font-size: 12px; color: #333;">&copy;版权所有：石家庄铁道大学信息科学与技术学院</div>
</body>
</html>
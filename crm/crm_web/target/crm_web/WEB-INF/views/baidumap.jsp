<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=exufoEGZL83tcGmfjXdC0cakv6uxIfqT"></script>
    <title>百度地图</title>
</head>
<body style="background:#CBE1FF">
<div style="width:730px;margin:auto;">
    要查询的地址：<input id="text_" type="text" value="" style="margin-right:100px;"/>
    查询结果(经纬度)：<input id="result_" type="text" />
    <input type="button" value="查询" onclick="searchByStationName();"/>
    <div id="container"
         style="position: absolute;
                margin-top:30px;
                width: 730px;
                height: 590px;
                top: 50;
                border: 1px solid gray;
                overflow:hidden;">
    </div>
</div>
</body>
<script type="text/javascript">
    var map = new BMap.Map("container");
    map.centerAndZoom("重庆", 15);
    map.enableDragging(); //启用地图拖拽事件，默认启用(可不写)
    map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
    map.enableDoubleClickZoom(); //启用鼠标双击放大，默认启用(可不写)
    map.enableKeyboard(); //启用键盘上下左右键移动地图

    map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
    map.addControl(new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT }));   //右下角，打开

    map.addEventListener("click", function () {
        var center = map.getCenter();
        document.getElementById("text1").value = center.lng;
        document.getElementById("text2").value = center.lat;
    });

    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
    function searchByStationName() {
        map.clearOverlays(); //清空原来的标注
        var keyword = document.getElementById("text_").value;
        localSearch.setSearchCompleteCallback(function (searchResult) {
            var poi = searchResult.getPoi(0);
            document.getElementById("result_").value = poi.point.lng + "," + poi.point.lat;
            map.centerAndZoom(poi.point, 16);

            document.getElementById("text1").value =  poi.point.lng;
            document.getElementById("text2").value = poi.point.lat;

            var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
            map.addOverlay(marker);
            marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
            // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
        });
        localSearch.search(keyword);
    }

    // 编写自定义函数，创建标注
    function addMarker(point) {

        // 创建图标对象
        var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {
            // 指定定位位置。
            // 当标注显示在地图上时，其所指向的地理位置距离图标左上
            // 角各偏移10像素和25像素。您可以看到在本例中该位置即是
            // 图标中央下端的尖角位置。
            offset: new BMap.Size(10, 25),
            // 设置图片偏移。
            // 当您需要从一幅较大的图片中截取某部分作为标注图标时，您
            // 需要指定大图的偏移位置，此做法与css sprites技术类似。
            imageOffset: new BMap.Size(0, 0 - 1 * 25)   // 设置图片偏移
        });

        // 创建标注对象并添加到地图
        var marker = new BMap.Marker(point);
        map.addOverlay(marker);

        //移除标注
        marker.addEventListener("click", function () {
            //            map.removeOverlay(marker);
            //            marker.dispose();

            var opts = {
                width: 250,     // 信息窗口宽度
                height: 100,     // 信息窗口高度
                title: "lng:" + point.lng + "lat:" + point.lat  // 信息窗口标题
            }

            var infoWindow = new BMap.InfoWindow("", opts);  // 创建信息窗口对象
            marker.openInfoWindow(infoWindow, this.point);      // 打开信息窗口
        });
    }

    $(document).ready(function () {
        $("#btn").click(function () {
            //var point = new BMap.Point(parseFloat($("#text1").val()) + 0.0065, parseFloat($("#text2").val()) + 0.0065);
            var point = new BMap.Point(parseFloat($("#text1").val()), parseFloat($("#text2").val()));
            addMarker(point);
        });
    });
</script>
</html>
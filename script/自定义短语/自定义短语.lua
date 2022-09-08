
require "import"
import "java.io.File"
import "android.os.*"

import "script.包.其它.主键盘"

local 参数=(...)
local 编号=1

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 数据文件=string.sub(脚本名,1,#脚本名-4)..".txt"



local 短语组1={}
local 当前脚本组1={}
local 短语数=5--单个键盘的短语数量
local 默认宽度=100

for c in io.lines(数据文件) do
 if c!="" then 短语组1[#短语组1+1]=c end
end--for

if string.sub(参数,1,1)=="<" && string.sub(参数,#参数,#参数)==">" then
 编号=tonumber(string.sub(参数,2,#参数-1))
end


local 总序号=math.ceil(#短语组1/短语数)
local 按键1={}
 按键1["width"]=100
 按键1["height"]=25
 按键1["click"]=""
 --按键1["click"]={label=短语组1[i],commit=短语组1[i]}
 按键1["label"]=string.sub(纯脚本名,1,#纯脚本名-4).."("..编号.."/"..总序号..")"
 当前脚本组1[#当前脚本组1+1]=按键1


if 编号==1 then
 if #短语组1<短语数 then
  for i=1,#短语组1 do
   当前脚本组1[#当前脚本组1+1]=短语组1[i]
  end--
  local 按键={}
  按键["width"]=100
  for i=1,短语数-#短语组1 do
   当前脚本组1[#当前脚本组1+1]=按键
  end--for
  当前脚本组1[#当前脚本组1+1]=主键盘()
 else
  
 当前脚本组1[#当前脚本组1+1]=按键2
  for i=1,短语数 do
   local 子编号=i
   if #短语组1>子编号-1 then
    当前脚本组1[#当前脚本组1+1]=短语组1[子编号]
   end--if
  end--for
 local 按键2={}
 按键2["width"]=50
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<"..(编号+1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键2
 local 按键3=主键盘()
 按键3["width"]=50
 当前脚本组1[#当前脚本组1+1]=按键3


 end--if #短语组1<25
end--if 编号==1

if 编号>1 then
if #短语组1<编号*短语数 then
  for i=1,#短语组1-(编号-1)*短语数 do
   当前脚本组1[#当前脚本组1+1]=短语组1[i+(编号-1)*短语数]
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数*编号-#短语组1 do
   当前脚本组1[#当前脚本组1+1]=按键
  end--for
  local 按键1={}
  按键1["width"]=50
  按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<"..(编号-1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键1
 local 按键3=主键盘()
 按键3["width"]=50
 当前脚本组1[#当前脚本组1+1]=按键3

else
  for i=1,短语数 do
   local 子编号=i
   if #短语组1>子编号-1 then
    当前脚本组1[#当前脚本组1+1]=短语组1[子编号+(编号-1)*短语数]
   end--if
  end--for
  local 按键1={}
  按键1["width"]=33
 按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<"..(编号-1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键1
 local 按键2={}
 按键2["width"]=33
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<"..(编号+1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键2
 local 按键3=主键盘()
 按键3["width"]=34
 当前脚本组1[#当前脚本组1+1]=按键3


end--if #短语组1>编号*22
end--if 编号>1 


service.setKeyboard{
  name=string.sub(纯脚本名,1,#纯脚本名-4),
  ascii_mode=0,
  width=默认宽度,
  height=32,
  keys=当前脚本组1
  }




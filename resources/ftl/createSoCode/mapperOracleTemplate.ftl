<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${objectName}Mapper">
	
	<!--表名 -->
	<sql id="tableName">
		"${tabletop}${objectNameUpper}"
	</sql>
	
	<!--数据字典表名 -->
	<sql id="dicTableName">
		"SYS_DICTIONARIES"
	</sql>
	
	<!-- 字段 -->
	<sql id="Field">
	<#list fieldList as var>
		f."${var[0]}",	
	</#list>
		f."${objectNameUpper}_ID",
		f."${faobject}_ID"
	</sql>
	
	<!-- 字段 -->
	<sql id="Field2">
	<#list fieldList as var>
		"${var[0]}",	
	</#list>
		"${objectNameUpper}_ID",
		"${faobject}_ID"
	</sql>
	
	<!-- 字段值 -->
	<sql id="FieldValue">
	<#list fieldList as var>
		${r"#{"}${var[0]}${r"}"},	
	</#list>
		${r"#{"}${objectNameUpper}_ID${r"}"},
		${r"#{"}${faobject}_ID${r"}"}
	</sql>
	
	<!-- 新增-->
	<insert id="save" parameterType="pd">
		insert into
		<include refid="tableName"></include>
		(
		<include refid="Field2"></include>
		) values (
		<include refid="FieldValue"></include>
		)
	</insert>
	
	<!-- 删除-->
	<delete id="delete" parameterType="pd">
		delete from
		<include refid="tableName"></include>
		where 
			"${objectNameUpper}_ID" = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</delete>
	
	<!-- 修改 -->
	<update id="edit" parameterType="pd">
		update
		<include refid="tableName"></include>
			set 
	<#list fieldList as var>
			<#if var[3] == "是">
				"${var[0]}" = ${r"#{"}${var[0]}${r"}"},	
			</#if>
	</#list>
				"${objectNameUpper}_ID" = "${objectNameUpper}_ID"
			where 
				"${objectNameUpper}_ID" = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</update>
	
	<!-- 通过ID获取数据 -->
	<select id="findById" parameterType="pd" resultType="pd">
		select 
		<include refid="Field"></include>
		from 
		<include refid="tableName"></include> f
		where 
			f."${objectNameUpper}_ID" = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</select>
	
	<!-- 列表 -->
	<select id="datalistPage" parameterType="page" resultType="pd">
		select
<#list fieldList as var>
	<#if var[3] == "是">
		<#if var[1] == 'String'>
			<#if var[7] != 'null'>
				d${var_index+1}."BIANMA" as "BIANMA${var_index+1}",
				d${var_index+1}."NAME" as "DNAME${var_index+1}",
			</#if>
		</#if>
	</#if>
</#list>
		<include refid="Field"></include>
		from 
		<include refid="tableName"></include> f
<#list fieldList as var>
	<#if var[3] == "是">
		<#if var[1] == 'String'>
			<#if var[7] != 'null'>
			left join 
			<include refid="dicTableName"></include> d${var_index+1}
			on f."${var[0]}" = d${var_index+1}."BIANMA"
			</#if>
		</#if>
	</#if>
</#list>
		where
			f."${faobject}_ID" = ${r"#{pd."}${faobject}_ID${r"}"}
		<if test="pd.keywords!= null and pd.keywords != ''"><!-- 关键词检索 -->
			and
				(
				<!--	根据需求自己加检索条件
					字段1 LIKE CONCAT(CONCAT('%', ${r"#{pd.keywords})"},'%')
					 or 
					字段2 LIKE CONCAT(CONCAT('%', ${r"#{pd.keywords})"},'%') 
				-->
				)
		</if>
	</select>
	
	<!-- 列表(全部) -->
	<select id="listAll" parameterType="pd" resultType="pd">
		select
		<include refid="Field"></include>
		from 
		<include refid="tableName"></include> f
	</select>
	
	<!-- 批量删除 -->
	<delete id="deleteAll" parameterType="String">
		delete from
		<include refid="tableName"></include>
		where 
			"${objectNameUpper}_ID" in
		<foreach item="item" index="index" collection="array" open="(" separator="," close=")">
                 ${r"#{item}"}
		</foreach>
	</delete>
	
	<!-- 查询明细总数 -->
	<select id="findCount" parameterType="pd" resultType="pd">
		select
			count(*) "zs"
		from 
			<include refid="tableName"></include>
		where
			"${faobject}_ID" = ${r"#{"}${faobject}_ID${r"}"}
	</select>
	

</mapper>
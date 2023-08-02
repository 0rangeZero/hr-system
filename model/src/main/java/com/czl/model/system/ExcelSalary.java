package com.czl.model.system;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentStyle;
import com.alibaba.excel.annotation.write.style.HeadFontStyle;
import com.alibaba.excel.enums.poi.HorizontalAlignmentEnum;
import lombok.Data;

@Data
@ColumnWidth(value = 11)
@HeadFontStyle(fontHeightInPoints = 11)
@ContentStyle(horizontalAlignment = HorizontalAlignmentEnum.LEFT)
public class ExcelSalary {

    @ExcelProperty("工号")
    private Long workId;

    @ExcelProperty("姓名")
    private String name;

    @ExcelProperty("所属部门")
    private String deptName;

    @ExcelProperty("职位")
    private String postName;

    @ExcelProperty("基本工资")
    private Long basicSalary;

    @ExcelProperty("绩效工资")
    private Long meritPay;

    @ExcelProperty("补助补贴")
    private Long allowance;

    @ExcelProperty("奖金")
    private Long bonus;

    @ExcelProperty("五险一金")
    private Long finsurances;

    @ExcelProperty("合计")
    private Long sum;

}

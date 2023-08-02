package com.czl.model.system;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentStyle;
import com.alibaba.excel.annotation.write.style.HeadFontStyle;
import com.alibaba.excel.enums.poi.HorizontalAlignmentEnum;
import lombok.Data;

@Data
@HeadFontStyle(fontHeightInPoints = 11)
@ContentStyle(horizontalAlignment = HorizontalAlignmentEnum.LEFT)
public class ExcelClock {

    @ExcelProperty("打卡日期")
    @ColumnWidth(value = 12)
    private String clockTime;

    @ExcelProperty("姓名")
    private String name;

    @ExcelProperty("性别")
    private String sex;

    @ExcelProperty("工号")
    @ColumnWidth(value = 10)
    private Long workId;

}

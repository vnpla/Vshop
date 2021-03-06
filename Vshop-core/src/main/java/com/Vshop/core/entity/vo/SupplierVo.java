package com.Vshop.core.entity.vo;

import java.io.Serializable;

import com.Vshop.core.entity.base.Supplier;

import lombok.Data;
import lombok.ToString;

/**
 * StoreSetting 店铺设置
 *    
 * 项目名称：Vshop-entity   
 * 类名称：Admin   
 * 类描述：   
 * 创建人：sangyuchen   
 * 创建时间：2014年11月20日 下午10:49:00   
 * 修改人：sangyuchen   
 * 修改时间：2014年11月20日 下午10:49:00   
 * 修改备注：   
 * @version    
 *
 */
@Data
@ToString
public class SupplierVo extends Supplier implements Serializable{
	
	private String sgName;
	
}

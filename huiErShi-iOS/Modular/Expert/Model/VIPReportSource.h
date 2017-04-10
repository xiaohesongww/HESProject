//
//  VIPReportSource.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "JSONModel.h"

@interface VIPReportSource : JSONModel
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSArray *consults;
@property (nonatomic,copy) NSString *reportNo;
@property (nonatomic, copy) NSString *imgroupId;
@end

@interface ConsultModel : JSONModel
@property (nonatomic,strong) NSDictionary *admin;//专家信息
@property (nonatomic,strong) NSString *advice; //专家建议
@property (nonatomic,strong) NSString *id;//这份报告的编号（显示在群聊左上角）
@property (nonatomic,strong) NSString *prescriptions;//处方列表
@property (nonatomic,strong) NSString *analysis;//报告分析
@end

@interface AdminModel : JSONModel
@property (nonatomic,strong) NSString *iconUrl;
@property (nonatomic,strong) NSString *job; //专家职业
@property (nonatomic,strong) NSString *name;//专家的名字
@property (nonatomic, copy) NSString *adminNo;
@property (nonatomic, copy) NSString *imUserId;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *id;

@end

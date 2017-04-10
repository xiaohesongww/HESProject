//
//  MeViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeViewController.h"
#import "MeItemHeardView.h"
#import "MeItemCollectionViewCell.h"
#import "MeMemberCardViewController.h"
#import "MeMemberDataViewController.h"
#import "MeHESMallViewController.h"
#import "MeMyDeviceViewController.h"
#import "MeFeedBackViewController.h"
#import "MeSetViewController.h"
#import "MeMyInfoViewController.h"

@interface MeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    //定义一个imageview来等同于这个黑线
    UIImageView *navBarHairlineImageView;
}

@property(nonatomic,strong)NSArray*items;
@property(nonatomic,strong)UICollectionView*itemsCollectionView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=HESCOLOR_THEME;
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [self loadDataArray];
    
    //加载ItemsCollectionView
    [self loadItemsCollectionView];
    
}
-(void)loadItemsCollectionView
{
    
    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.itemSize = CGSizeMake((kScreenWidth-2)/3,LayOutH(200));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0, 0.f, 0);
    
    _itemsCollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _itemsCollectionView.backgroundColor=[UIColor clearColor];
    _itemsCollectionView.dataSource=self;
    _itemsCollectionView.delegate=self;
    [self.view addSubview:_itemsCollectionView];
    
    _itemsCollectionView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    //注册cell
    [_itemsCollectionView registerClass:[MeItemCollectionViewCell class] forCellWithReuseIdentifier:@"itemsCellId"];
    //注册heardView
    [_itemsCollectionView  registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"itemsheadID"];
    
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeItemCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"itemsCellId" forIndexPath:indexPath];
    MeItemModel *item=_items[indexPath.row];
    cell.item=item;
    
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray*controllers=@[@"MeMemberCardViewController",@"MeMemberDataViewController",@"MeHESMallViewController",@"MeMyDeviceViewController",@"MeFeedBackViewController",@"MeSetViewController"];
    Class class = NSClassFromString(controllers[indexPath.row]);
    id obj = [[class alloc] init];
    [self.navigationController pushViewController:(UIViewController*)obj animated:YES];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"itemsheadID" forIndexPath:indexPath];
        MeItemHeardView *heardView = [[MeItemHeardView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, LayOutH(316))];
        @weakify(self);
        heardView.clickHeardBtn=^{
            @strongify(self);
            MeMyInfoViewController *myInfoVc=[[MeMyInfoViewController alloc]init];
            myInfoVc.setName = ^(NSString *name){
                 heardView.nikeNameLab.text = name;
            };
            
            myInfoVc.setIcon = ^(UIImage *icon) {
                [heardView.heardBtn setImage:icon forState:UIControlStateNormal];
            };
            [self.navigationController pushViewController:myInfoVc animated:YES];
        };
        [view addSubview:heardView];
        reusableview = view;
    }
    return reusableview;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, LayOutH(336));
}
//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
    cell.backgroundColor=HESHEXCOLOR(@"f2f2f2");
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
    cell.backgroundColor=[UIColor whiteColor];
}
-(void)loadDataArray{
    
    NSMutableArray *dataArray=[NSMutableArray array];
    NSArray *titles=@[@"会员卡",@"会籍资料",@"惠尔仕商城",@"我的设备",@"反馈",@"设置"];

    for (int i=0; i<titles.count; i++) {
        NSString *title=titles[i];
        MeItemModel *item=[[MeItemModel alloc]init];
        item.item_img=title;
        item.item_title=title;
        [dataArray addObject:item];
    }
    _items=[dataArray copy];
}
//通过方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
//同样的在界面出现时候开启隐藏
-(void)viewWillAppear:(BOOL)animated{
    navBarHairlineImageView.hidden = YES;
}
//在页面消失的时候就让出现
-(void)viewWillDisappear:(BOOL)animated{
    navBarHairlineImageView.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ActivityMembersCell.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ActivityMembersCell.h"
#import "MemberCell.h"
@interface ActivityMembersCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation ActivityMembersCell
static NSString *MemberCellId = @"MemberCellId";
- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout *flowLaout = [[UICollectionViewFlowLayout alloc] init];

    flowLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.collectionViewLayout = flowLaout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MemberCell" bundle:nil] forCellWithReuseIdentifier:@"MemberCellId"];
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.memberArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MemberCellId" forIndexPath:indexPath];
    [cell.memberIcon sd_setImageWithURL:nil placeholderImage:GETIMG(@"头像1")];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40,40);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end

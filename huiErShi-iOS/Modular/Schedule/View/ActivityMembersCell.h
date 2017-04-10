//
//  ActivityMembersCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "BaseCell.h"

@interface ActivityMembersCell : BaseCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *memberArr;
@end

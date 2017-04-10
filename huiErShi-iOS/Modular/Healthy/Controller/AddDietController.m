//
//  AddDietController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "AddDietController.h"
#import "AddDietHeaderView.h"
#import "ChooseDietController.h"

static NSString * const reuseIdentifier = @"Cell";
@interface AddDietController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    BOOL close[6];
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, getter=isSearching) BOOL searching;
@end

@implementation AddDietController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 6; i++) {
        close[i] = NO;
    }
    
    // Do any additional setup after loading the view.
    self.title = @"添加饮食";
    self.view.backgroundColor = HESCOLOR_THEME;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    AddDietHeaderView *addDietHeaderView = [[NSBundle mainBundle] loadNibNamed:@"AddDietHeaderView" owner:self options:nil].lastObject;
    addDietHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    addDietHeaderView.dietSearchBar.delegate = self;
    self.tableView.tableHeaderView = addDietHeaderView;
    [self.tableView addSubview:self.tableView.tableHeaderView];
    
    self.view = self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearching) {
        return 1;
    }
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (close[section]) {
        return 0;
    }
    if (section == 0) {
        return 6;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"面条";
                break;
            case 1:
                cell.textLabel.text = @"包子(荤)";
                break;
            case 2:
                cell.textLabel.text = @"饺子(素)";
                break;
            case 3:
                cell.textLabel.text = @"玉米(鲜)";
                break;
            case 4:
                cell.textLabel.text = @"蛋糕";
                break;
            case 5:
                cell.textLabel.text = @"饼干";
                break;
                
            default:
                break;
        }
    }
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LayOutH(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isSearching) {
        return nil;
    }
    UIView *sectionHeaderView = [[UIView alloc] init];
    
    UILabel *sectionTitleLabel = [[UILabel alloc] init];
    sectionTitleLabel.font = LayOutFont(32);
    sectionTitleLabel.textAlignment = NSTextAlignmentCenter;
    sectionTitleLabel.textColor = HESHEXCOLOR(@"ffffff");
    [sectionHeaderView addSubview:sectionTitleLabel];
    sectionTitleLabel.sd_layout
    .topSpaceToView(sectionHeaderView, LayOutH(20))
    .bottomSpaceToView(sectionHeaderView, LayOutH(20))
    .widthIs(LayOutW(300))
    .centerXEqualToView(sectionHeaderView);
    
    UIButton *foldButton = [[UIButton alloc] init];
    foldButton.tag = 100 + section;
    foldButton.backgroundColor = [UIColor redColor];
    [sectionHeaderView addSubview:foldButton];
    foldButton.sd_layout
    .rightSpaceToView(sectionHeaderView, LayOutW(20))
    .centerYEqualToView(sectionHeaderView)
    .widthIs(LayOutW(18))
    .heightIs(LayOutH(10));
    
    [foldButton addTarget:self action:@selector(foldButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    switch (section) {
        case 0:
            sectionHeaderView.backgroundColor = HESHEXCOLOR(@"1785cf");
            sectionTitleLabel.text = @"谷薯类";
            break;
        case 1:
            sectionHeaderView.backgroundColor = HESHEXCOLOR(@"17d4e4");
            sectionTitleLabel.text = @"蔬菜水果类";
            break;
        case 2:
            sectionHeaderView.backgroundColor = HESHEXCOLOR(@"17be72");
            sectionTitleLabel.text = @"畜禽鱼蛋奶类";
            break;
        case 3:
            sectionHeaderView.backgroundColor = HESHEXCOLOR(@"b5d917");
            sectionTitleLabel.text = @"大豆坚果类";
            break;
        case 4:
            sectionHeaderView.backgroundColor = HESHEXCOLOR(@"fdb317");
            sectionTitleLabel.text = @"纯能量食物";
            break;
        case 5:
            sectionHeaderView.backgroundColor = HESHEXCOLOR(@"fc424a");
            sectionTitleLabel.text = @"其他";
            break;
            
        default:
            break;
    }
    return sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChooseDietController *chooseDietVC = [[ChooseDietController alloc] init];
    [self.navigationController pushViewController:chooseDietVC animated:YES];
}

- (void)foldButtonPressed:(UIButton *)sender {
    // 获取 tag
    NSInteger buttonTag = sender.tag - 100;
    close[buttonTag] = !close[buttonTag];
    // 刷新列表
    [self.tableView reloadSection:buttonTag withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UISearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    self.searching = YES;
    [self.tableView reloadData];
    return YES;
}


@end

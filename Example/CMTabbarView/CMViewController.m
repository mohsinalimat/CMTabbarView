//
//  CMViewController.m
//  CMTabbarView
//
//  Created by momo605654602@gmail.com on 03/07/2017.
//  Copyright (c) 2017 momo605654602@gmail.com. All rights reserved.
//

#import "CMViewController.h"
#import "CMTabbarView.h"
#import "CMTabbarCollectionViewCell.h"
#define MHEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

@interface CMViewController ()<CMTabbarViewDelegate,CMTabbarViewDatasouce,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) CMTabbarView *tabbarView;
@property (strong, nonatomic) NSArray *datas;

@end

@implementation CMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datas = @[@"Moyun",@"Penny",@"MoyunMoyun",@"M",@"Pe",@"Moy",@"Moyun",@"Penny",@"Swift",@"Cbjective-C",@"C++",@"JAVA",@"C"];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tabbarView];
}

- (CMTabbarView *)tabbarView
{
    if (!_tabbarView) {
        _tabbarView = [[CMTabbarView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
        _tabbarView.delegate = self;
        _tabbarView.dataSource = self;
        //_tabbarView.selectionType = CMTabbarSelectionBox;
        //_tabbarView.indicatorAttributes = @{CMTabIndicatorColor:[UIColor orangeColor]};
        //_tabbarView.normalAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        //_tabbarView.selectedAttributes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
        //_tabbarView.needTextGradient = false;
        //_tabbarView.defaultSelectedIndex = 5;
    }
    return _tabbarView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[CMTabbarCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CMTabbarCollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.pagingEnabled = true;
        //_collectionView.contentOffset = CGPointMake(self.view.bounds.size.width*5, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSArray<NSString *> *)tabbarTitlesForTabbarView:(CMTabbarView *)tabbarView
{
    return self.datas;
}

- (void)tabbarView:(CMTabbarView *)tabbarView1 didSelectedAtIndex:(NSInteger)index
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMTabbarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CMTabbarCollectionViewCell class]) forIndexPath:indexPath];
    cell.title = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_tabbarView setTabbarOffsetX:(scrollView.contentOffset.x)/self.view.bounds.size.width];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@class B4I;
@class B4ILocalPlayer;
@class B4IGKScore;

//~version: 1.01
//~dependson: GameKit.framework
//~shortname: GKGameCenter
//~event: AuthenticationStateChanged (Authenticated As Boolean, ShouldShowDialog As Boolean)
//~event: ScoreSubmitted (Success As Boolean)
//~event: ScoresAvailable (Success As Boolean, Scores As List, PlayerScore As GKScore)

@interface B4IGameCenter : NSObject
/**
 * Returns the local player object. Only relevant after the user authenticated.
 */
@property (nonatomic, readonly)B4ILocalPlayer* LocalPlayer;

- (void)Initialize:(B4I *)bi :(NSString *)EventName;
/**
 * Shows the authentication dialog. Only call this method if AuthenticationStateChanged was raised with ShouldShowDialog set to True.
 */
- (void)ShowDialog:(B4IPage *)Parent;
/**
 * Submits a score and raises the ScoreSubmitted event. Returns an object that can be used as the sender filter parameter.
 */
- (NSObject *)SubmitScore:(B4IGKScore *)Score;
/**
 * Requests scores for the given board. The ScoresAvailable event will be raised.
 *Returns an object that can be used as the sender filter parameter.
 */
- (NSObject *)RequestScores:(NSString *)BoardId;
@end

//~shortname: GKPlayer
//~ObjectWrapper: GKPlayer*
@interface B4IGKPlayer:B4IObjectWrapper
@property (nonatomic, readonly) NSString *PlayerId;
@property (nonatomic, readonly) NSString *DisplayName;
@property (nonatomic, readonly) NSString *Alias;
@end

//~shortname: GKLocalPlayer
//~ObjectWrapper: GKLocalPlayer*
@interface B4ILocalPlayer:B4IGKPlayer
@property (nonatomic, readonly) BOOL Authenticated;
@end

//~shortname: GKScore
//~ObjectWrapper: GKScore*
@interface B4IGKScore : B4IObjectWrapper
@property (nonatomic) long long Value;
@property (nonatomic, readonly) int Rank;
@property (nonatomic, readonly) B4IGKPlayer *Player;
@property (nonatomic, readonly) long long Date;
/**
 * Used to create new score objects that can be submitted with GKGameCenter.SubmitScore.
 */
- (void)Initialize:(NSString *)BoardId;
@end
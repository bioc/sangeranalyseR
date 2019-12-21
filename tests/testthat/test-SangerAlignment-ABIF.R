test_that("SangerAlignment Initial test", {
    expect_type(sangerAlignment, "S4")
    expect_s4_class(sangerAlignment, "SangerAlignment")
    expect_equal(sangerAlignment@inputSource, "ABIF")
    expect_equal(sangerAlignment@fastaFileName, "")
    expect_equal(sangerAlignment@suffixForwardRegExp, "_[0-9]*_F.ab1")
    expect_equal(sangerAlignment@suffixReverseRegExp, "_[0-9]*_R.ab1")
    expect_equal(sangerAlignment@trimmingMethodSA, "M1")
    expect_equal(sangerAlignment@minFractionCallSA, 0.5)
    expect_equal(sangerAlignment@maxFractionLostSA, 0.5)
    expect_equal(sangerAlignment@refAminoAcidSeq, "SRQWLFSTNHKDIGTLYFIFGAWAGMVGTSLSILIRAELGHPGALIGDDQIYNVIVTAHAFIMIFFMVMPIMIGGFGNWLVPLMLGAPDMAFPRMNNMSFWLLPPALSLLLVSSMVENGAGTGWTVYPPLSAGIAHGGASVDLAIFSLHLAGISSILGAVNFITTVINMRSTGISLDRMPLFVWSVVITALLLLLSLPVLAGAITMLLTDRNLNTSFFDPAGGGDPILYQHLFWFFGHPEVYILILPGFGMISHIISQESGKKETFGSLGMIYAMLAIGLLGFIVWAHHMFTVGMDVDTRAYFTSATMIIAVPTGIKIFSWLATLHGTQLSYSPAILWALGFVFLFTVGGLTGVVLANSSVDIILHDTYYVVAHFHYVLSMGAVFAIMAGFIHWYPLFTGLTLNNKWLKSHFIIMFIGVNLTFFPQHFLGLAGMPRRYSDYPDAYTTWNIVSTIGSTISLLGILFFFFIIWESLVSQRQVIYPIQLNSSIEWYQNTPPAEHSYSELPLLTN")
    expect_equal(as.character(sangerAlignment@contigsConsensus), "TAATATATCGRCGGCCAGTGGTCAACAAATCATAAAGATATTGGAACTYTATAYTTTATTYTRGGCGTCTGAGCAGGAATGGTTGGAGCYGGTATAAGACTYCTAATTCGAATYGAGCTAAGACARCCRGGAGCRTTCCTRGGMAGRGAYCAACTMTAYAATACTATYGTWACTGCWCACGCATTTGTAATAATYTTCTTTCTAGTAATRCCTGTATTYATYGGGGGRTTCGGWAAYTGRCTTYTACCTTTAATACTTGGAGCCCCYGAYATRGCATTCCCWCGACTYAACAACATRAGATTCTGACTMCTTCCCCCATCACTRATCCTTYTAGTGTCCTCTGCKGCRGTAGAAAAAGGCGCTGGWACKGGRTGAACTGTTTATCCGCCYCTAGCAAGAAATMTTGCYCAYGCMGGCCCRTCTGTAGAYTTAGCYATYTTTTCYCTTCATTTAGCGGGTGCKTCWTCWATYYTAGGGGCYATTAATTTTATYACYACWGTTATTAAYATGCGWTGAAGAGGMTTACGWCTTGAACGAATYCCMYTRTTYGTYTGAGCYGTRCTAATTACAGTKGTTCTTCTACTYCTATCYTTACCAGTGYTAGCMGGTGCMATTACYATACTWCTTACCGAYCGAAATCTAAATACCTCCTTCTTTGATCCTGCTGGDGGTGGAGAYCCMATCCTMTACCAACACTTATTCTGATTTTTTGGTCACCCTGAG")

    expect_equal(sangerAlignment@contigsTree$tip.label[1], "ACHLO006-09[LCO1490_t1,HCO2198_t1]")
    expect_equal(sangerAlignment@contigsTree$tip.label[2], "ACHLO007-09[LCO1490_t1,HCO2198_t1]")
    expect_equal(sangerAlignment@contigsTree$tip.label[3], "ACHLO040-09[LCO1490_t1,HCO2198_t1]")
    expect_equal(sangerAlignment@contigsTree$tip.label[4], "ACHLO041-09[LCO1490_t1,HCO2198_t1]")
})



test_that("SangerAlignment update quality trimming parameters test 1 - M1", {
    newTrimmedSangerAlignment <- updateQualityParam(sangerAlignment,
                                                 TrimmingMethod       = "M1",
                                                 M1TrimmingCutoff     = 0.1,
                                                 M2CutoffQualityScore = NULL,
                                                 M2SlidingWindowSize  = NULL)
    expect_equal(newTrimmedSangerAlignment@trimmingMethodSA, "M1")
    sapply(newTrimmedSangerAlignment@contigList, function(contig) {
        expect_type(contig, "S4")
        expect_s4_class(contig, "SangerContig")
        expect_equal(contig@inputSource, "ABIF")
        expect_equal(contig@suffixForwardRegExp, "_[0-9]*_F.ab1")
        expect_equal(contig@suffixReverseRegExp, "_[0-9]*_R.ab1")
        expect_equal(contig@trimmingMethodSC, "M1")
        expect_equal(contig@minReadsNum, 2)
        expect_equal(contig@minReadLength, 20)
        expect_equal(contig@refAminoAcidSeq, "SRQWLFSTNHKDIGTLYFIFGAWAGMVGTSLSILIRAELGHPGALIGDDQIYNVIVTAHAFIMIFFMVMPIMIGGFGNWLVPLMLGAPDMAFPRMNNMSFWLLPPALSLLLVSSMVENGAGTGWTVYPPLSAGIAHGGASVDLAIFSLHLAGISSILGAVNFITTVINMRSTGISLDRMPLFVWSVVITALLLLLSLPVLAGAITMLLTDRNLNTSFFDPAGGGDPILYQHLFWFFGHPEVYILILPGFGMISHIISQESGKKETFGSLGMIYAMLAIGLLGFIVWAHHMFTVGMDVDTRAYFTSATMIIAVPTGIKIFSWLATLHGTQLSYSPAILWALGFVFLFTVGGLTGVVLANSSVDIILHDTYYVVAHFHYVLSMGAVFAIMAGFIHWYPLFTGLTLNNKWLKSHFIIMFIGVNLTFFPQHFLGLAGMPRRYSDYPDAYTTWNIVSTIGSTISLLGILFFFFIIWESLVSQRQVIYPIQLNSSIEWYQNTPPAEHSYSELPLLTN")
        expect_equal(contig@minFractionCall, 0.5)
        expect_equal(contig@maxFractionLost, 0.5)
        expect_equal(contig@acceptStopCodons, TRUE)
        expect_equal(contig@readingFrame, 1)
        sapply(contig@forwardReadList, function(forwardRead) {
            expect_equal(forwardRead@QualityReport@TrimmingMethod, "M1")
            expect_equal(forwardRead@QualityReport@M1TrimmingCutoff, 0.1, tolerance=1e-10)
            expect_equal(forwardRead@QualityReport@M2CutoffQualityScore, NULL)
            expect_equal(forwardRead@QualityReport@M2SlidingWindowSize, NULL)
        })
    })

    sapply(newTrimmedSangerAlignment@contigList, function(contig) {
        expect_type(contig, "S4")
        expect_s4_class(contig, "SangerContig")
        expect_equal(contig@inputSource, "ABIF")
        expect_equal(contig@suffixForwardRegExp, "_[0-9]*_F.ab1")
        expect_equal(contig@suffixReverseRegExp, "_[0-9]*_R.ab1")
        expect_equal(contig@trimmingMethodSC, "M1")
        expect_equal(contig@minReadsNum, 2)
        expect_equal(contig@minReadLength, 20)
        expect_equal(contig@refAminoAcidSeq, "SRQWLFSTNHKDIGTLYFIFGAWAGMVGTSLSILIRAELGHPGALIGDDQIYNVIVTAHAFIMIFFMVMPIMIGGFGNWLVPLMLGAPDMAFPRMNNMSFWLLPPALSLLLVSSMVENGAGTGWTVYPPLSAGIAHGGASVDLAIFSLHLAGISSILGAVNFITTVINMRSTGISLDRMPLFVWSVVITALLLLLSLPVLAGAITMLLTDRNLNTSFFDPAGGGDPILYQHLFWFFGHPEVYILILPGFGMISHIISQESGKKETFGSLGMIYAMLAIGLLGFIVWAHHMFTVGMDVDTRAYFTSATMIIAVPTGIKIFSWLATLHGTQLSYSPAILWALGFVFLFTVGGLTGVVLANSSVDIILHDTYYVVAHFHYVLSMGAVFAIMAGFIHWYPLFTGLTLNNKWLKSHFIIMFIGVNLTFFPQHFLGLAGMPRRYSDYPDAYTTWNIVSTIGSTISLLGILFFFFIIWESLVSQRQVIYPIQLNSSIEWYQNTPPAEHSYSELPLLTN")
        expect_equal(contig@minFractionCall, 0.5)
        expect_equal(contig@maxFractionLost, 0.5)
        expect_equal(contig@acceptStopCodons, TRUE)
        expect_equal(contig@readingFrame, 1)
        sapply(contig@reverseReadList, function(reverseRead) {
            expect_equal(reverseRead@QualityReport@TrimmingMethod, "M1")
            expect_equal(reverseRead@QualityReport@M1TrimmingCutoff, 0.1, tolerance=1e-10)
            expect_equal(reverseRead@QualityReport@M2CutoffQualityScore, NULL)
            expect_equal(reverseRead@QualityReport@M2SlidingWindowSize, NULL)
        })
    })
})

test_that("SangerAlignment update quality trimming parameters test 2 - M2", {
    newTrimmedSangerAlignment <- updateQualityParam(sangerAlignment,
                                                    TrimmingMethod       = "M2",
                                                    M1TrimmingCutoff     = NULL,
                                                    M2CutoffQualityScore = 35,
                                                    M2SlidingWindowSize  = 15)
    expect_equal(newTrimmedSangerAlignment@trimmingMethodSA, "M2")
    sapply(newTrimmedSangerAlignment@contigList, function(contig) {
        expect_type(contig, "S4")
        expect_s4_class(contig, "SangerContig")
        expect_equal(contig@inputSource, "ABIF")
        expect_equal(contig@suffixForwardRegExp, "_[0-9]*_F.ab1")
        expect_equal(contig@suffixReverseRegExp, "_[0-9]*_R.ab1")
        expect_equal(contig@trimmingMethodSC, "M2")
        expect_equal(contig@minReadsNum, 2)
        expect_equal(contig@minReadLength, 20)
        expect_equal(contig@refAminoAcidSeq, "SRQWLFSTNHKDIGTLYFIFGAWAGMVGTSLSILIRAELGHPGALIGDDQIYNVIVTAHAFIMIFFMVMPIMIGGFGNWLVPLMLGAPDMAFPRMNNMSFWLLPPALSLLLVSSMVENGAGTGWTVYPPLSAGIAHGGASVDLAIFSLHLAGISSILGAVNFITTVINMRSTGISLDRMPLFVWSVVITALLLLLSLPVLAGAITMLLTDRNLNTSFFDPAGGGDPILYQHLFWFFGHPEVYILILPGFGMISHIISQESGKKETFGSLGMIYAMLAIGLLGFIVWAHHMFTVGMDVDTRAYFTSATMIIAVPTGIKIFSWLATLHGTQLSYSPAILWALGFVFLFTVGGLTGVVLANSSVDIILHDTYYVVAHFHYVLSMGAVFAIMAGFIHWYPLFTGLTLNNKWLKSHFIIMFIGVNLTFFPQHFLGLAGMPRRYSDYPDAYTTWNIVSTIGSTISLLGILFFFFIIWESLVSQRQVIYPIQLNSSIEWYQNTPPAEHSYSELPLLTN")
        expect_equal(contig@minFractionCall, 0.5)
        expect_equal(contig@maxFractionLost, 0.5)
        expect_equal(contig@acceptStopCodons, TRUE)
        expect_equal(contig@readingFrame, 1)
        sapply(contig@forwardReadList, function(forwardRead) {
            expect_equal(forwardRead@QualityReport@TrimmingMethod, "M2")
            expect_equal(forwardRead@QualityReport@M1TrimmingCutoff, NULL)
            expect_equal(forwardRead@QualityReport@M2CutoffQualityScore, 35, tolerance=1e-10)
            expect_equal(forwardRead@QualityReport@M2SlidingWindowSize, 15, tolerance=1e-10)
        })
    })

    sapply(newTrimmedSangerAlignment@contigList, function(contig) {
        expect_type(contig, "S4")
        expect_s4_class(contig, "SangerContig")
        expect_equal(contig@inputSource, "ABIF")
        expect_equal(contig@suffixForwardRegExp, "_[0-9]*_F.ab1")
        expect_equal(contig@suffixReverseRegExp, "_[0-9]*_R.ab1")
        expect_equal(contig@trimmingMethodSC, "M2")
        expect_equal(contig@minReadsNum, 2)
        expect_equal(contig@minReadLength, 20)
        expect_equal(contig@refAminoAcidSeq, "SRQWLFSTNHKDIGTLYFIFGAWAGMVGTSLSILIRAELGHPGALIGDDQIYNVIVTAHAFIMIFFMVMPIMIGGFGNWLVPLMLGAPDMAFPRMNNMSFWLLPPALSLLLVSSMVENGAGTGWTVYPPLSAGIAHGGASVDLAIFSLHLAGISSILGAVNFITTVINMRSTGISLDRMPLFVWSVVITALLLLLSLPVLAGAITMLLTDRNLNTSFFDPAGGGDPILYQHLFWFFGHPEVYILILPGFGMISHIISQESGKKETFGSLGMIYAMLAIGLLGFIVWAHHMFTVGMDVDTRAYFTSATMIIAVPTGIKIFSWLATLHGTQLSYSPAILWALGFVFLFTVGGLTGVVLANSSVDIILHDTYYVVAHFHYVLSMGAVFAIMAGFIHWYPLFTGLTLNNKWLKSHFIIMFIGVNLTFFPQHFLGLAGMPRRYSDYPDAYTTWNIVSTIGSTISLLGILFFFFIIWESLVSQRQVIYPIQLNSSIEWYQNTPPAEHSYSELPLLTN")
        expect_equal(contig@minFractionCall, 0.5)
        expect_equal(contig@maxFractionLost, 0.5)
        expect_equal(contig@acceptStopCodons, TRUE)
        expect_equal(contig@readingFrame, 1)
        sapply(contig@reverseReadList, function(reverseRead) {
            expect_equal(reverseRead@QualityReport@TrimmingMethod, "M2")
            expect_equal(reverseRead@QualityReport@M1TrimmingCutoff, NULL)
            expect_equal(reverseRead@QualityReport@M2CutoffQualityScore, 35, tolerance=1e-10)
            expect_equal(reverseRead@QualityReport@M2SlidingWindowSize, 15, tolerance=1e-10)
        })
    })
})

test_that("sangerAlignment update quality trimming parameters 3 (M2CutoffQualityScore bigger than threashold)", {
    expect_error(updateQualityParam(sangerAlignment,
                                    TrimmingMethod       = "M2",
                                    M1TrimmingCutoff     = NULL,
                                    M2CutoffQualityScore = 61,
                                    M2SlidingWindowSize  = 41),
                 "\nYour input M2CutoffQualityScore is: '61' is invalid.'M2CutoffQualityScore' shouldbe between 0 and 60.\n\nYour input M2SlidingWindowSize is: '41' is invalid.'M2SlidingWindowSize' shouldbe between 0 and 40.\n", fixed = TRUE)
})
test_that("sangerAlignment update quality trimming parameters 4 (M2CutoffQualityScore smaller than threashold)", {
    expect_error(updateQualityParam(sangerAlignment,
                                    TrimmingMethod       = "M2",
                                    M1TrimmingCutoff     = NULL,
                                    M2CutoffQualityScore = -1,
                                    M2SlidingWindowSize  = -1),
                 "\nYour input M2CutoffQualityScore is: '-1' is invalid.'M2CutoffQualityScore' shouldbe between 0 and 60.\n\nYour input M2SlidingWindowSize is: '-1' is invalid.'M2SlidingWindowSize' shouldbe between 0 and 40.\n", fixed = TRUE)
})